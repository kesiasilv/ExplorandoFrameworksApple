//
//  LineChartView.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 18/10/25.
//

import SwiftUI
import Charts

struct LineChartView: View {
    var mockData = ViewDado.mockData //dados
    
    var body: some View {

            Chart{ //criado o grafico a partir da matriz de dados
                
                ForEach(mockData) { viewDado in
                    //criadno uma vizualizacao de grafico do tipo de barras
                    RectangleMark(
                        x: .value("Ano", viewDado.date, unit: .month),
                        y: .value("Dados", viewDado.viewCount)
                        )
                    //criando uma personalizacao básica:
                    .foregroundStyle(Color.pink.gradient)
                }
            }
            .frame(height: 180)  //definindo um tamanho para o gráfico
         
            .chartXAxis{ //personaliza o eixo X
                AxisMarks(values: mockData.map { $0.date }) { date in
                    AxisGridLine() //adiciona linhas como uma grade
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                }
            }
    
            .chartYAxis{//personaliza o eixo Y
                AxisMarks{ mark in
                    AxisValueLabel()
                    AxisGridLine()
                }

            }
    }
}

#Preview {
    LineChartView()
}
