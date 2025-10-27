//
//  ClickChart.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 20/10/25.
//

import Foundation
import SwiftUI
import Charts

/// Wrapper para tornar barras ou outros elementos do gráfico clicáveis
struct ClickChart<Content: ChartContent>: View {
    
    let content: () -> Content
    
    /// Data que será usada para identificar o ponto clicado
    @Binding var selectedDate: Date?
    
    /// Ação que será executada quando uma barra for tocada
    let onTap: (Date) -> Void
    
    init(selectedDate: Binding<Date?>,
         onTap: @escaping (Date) -> Void,
         @ChartContentBuilder content: @escaping () -> Content) {
        self._selectedDate = selectedDate
        self.onTap = onTap
        self.content = content
    }
    
    var body: some View {
        Chart {
            content()
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                // Converte a posição do toque para valor do eixo X
                                if let xValue: Date = proxy.value(atX: value.location.x) {
                                    selectedDate = xValue
                                    onTap(xValue)
                                }
                            }
                    )
            }
        }
    }
}
