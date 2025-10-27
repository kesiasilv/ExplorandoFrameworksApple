//
//  ZoomChart.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 20/10/25.
//


import SwiftUI
import Charts

/// Wrapper reutilizável para gráficos com zoom
struct ZoomChart<Content: ChartContent>: View {
    
    // MARK: - Conteúdo do gráfico
    let content: () -> Content
    
    // MARK: - Estado de zoom
    @State private var magnification: CGFloat = 1.0
    @State private var lastMagnification: CGFloat = 1.0
    
    // MARK: - Range atual dos eixos
    @State private var xRange: ClosedRange<Date>?
    @State private var yRange: ClosedRange<Int>?
    
    // MARK: - Range completo
    let xFullRange: ClosedRange<Date>
    let yFullRange: ClosedRange<Int>
    
    // MARK: - Inicializador
    init(
        xFullRange: ClosedRange<Date>,
        yFullRange: ClosedRange<Int>,
        @ChartContentBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.xFullRange = xFullRange
        self.yFullRange = yFullRange
        self._xRange = State(initialValue: xFullRange)
        self._yRange = State(initialValue: yFullRange)
    }
    
    var body: some View {
        Chart {
            content()
        }
        .chartXScale(domain: xRange ?? xFullRange)
        .chartYScale(domain: yRange ?? yFullRange)
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    magnification = lastMagnification * value
                    updateRanges()
                }
                .onEnded { _ in
                    lastMagnification = magnification
                }
        )
        .animation(.easeInOut(duration: 0.2), value: magnification)
    }
    
    private func updateRanges() {
        // X Axis (Date)
        let xInterval = xFullRange.upperBound.timeIntervalSince1970 - xFullRange.lowerBound.timeIntervalSince1970
        let xCenter = xFullRange.lowerBound.timeIntervalSince1970 + xInterval / 2
        let xHalfInterval = (xInterval / 2) / Double(magnification)
        let newXLower = Date(timeIntervalSince1970: xCenter - xHalfInterval)
        let newXUpper = Date(timeIntervalSince1970: xCenter + xHalfInterval)
        xRange = newXLower...newXUpper
        
        // Y Axis (Int)
        let yInterval = yFullRange.upperBound - yFullRange.lowerBound
        let yCenter = yFullRange.lowerBound + yInterval / 2
        let yHalfInterval = Int(Double(yInterval) / 2.0 / Double(magnification))
        let newYLower = yCenter - yHalfInterval
        let newYUpper = yCenter + yHalfInterval
        yRange = newYLower...newYUpper
    }
}
