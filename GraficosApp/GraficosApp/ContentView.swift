//
//  ContentView.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI
import Charts //importando a framework responsavel por criar a vizualizacao de graficos

struct ContentView: View {
    
    //aqui criamos a vizualizacao dos daods oque sera exibido nesse caso um array de numeros por anos
    let viewDados: [ViewDado] = [
        .init(date: Date.from(year: 2025, month: 01, day: 01), viewCount: 1340),
        .init(date: Date.from(year: 2025, month: 02, day: 01), viewCount: 3245),
        .init(date: Date.from(year: 2025, month: 03, day: 01), viewCount: 6785),
        .init(date: Date.from(year: 2025, month: 04, day: 01), viewCount: 2889),
        .init(date: Date.from(year: 2025, month: 05, day: 01), viewCount: 3472),
        .init(date: Date.from(year: 2025, month: 06, day: 01), viewCount: 7773),
        .init(date: Date.from(year: 2025, month: 07, day: 01), viewCount: 2203),
        .init(date: Date.from(year: 2025, month: 08, day: 01), viewCount: 6646),
        .init(date: Date.from(year: 2025, month: 09, day: 01), viewCount: 1030),
        .init(date: Date.from(year: 2025, month: 10, day: 01), viewCount: 3256),
        .init(date: Date.from(year: 2025, month: 11, day: 01), viewCount: 3321),
        .init(date: Date.from(year: 2025, month: 12, day: 01), viewCount: 3321)
    ]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4){
            
            //criando uma descricao do grafico:
            Text("Gastos Mensais")
            Text("Ano atual: 2025")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            
            Chart{ //criado o grafico a partir dos dados da matriz que criamos
                
                RuleMark(y: .value("Meta", 6500)) //aqui é uma linha de "meta" do gráfico (ps: se eu colocar depois do ForEach essa linha passa a ficar por cima do grafico como uma ZStack mesmo)
                
//                    //personalizacap da linha e de titulo:
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//                    .annotation(alignment: .topLeading){ //titulo que mostra que a linha tracejada seria a meta
//                        Text("Meta")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//            
//                    }
 
                ForEach(viewDados) { viewDado in
                    //criadno uma vizualizacao de grafico do tipo de barras "BarMark", aqui que mudo o tipo de vizualizacao "LineMark" e outros..
                    BarMark(
                        x: .value("Ano", viewDado.date, unit: .month),
                        y: .value("Dados", viewDado.viewCount)
                        )
                    //criando uma personalizacao básica:
                    .foregroundStyle(Color.pink.gradient)
//                    .cornerRadius(10) //pontas arrendondadas
                }//tudo isso atual como uma ZStack ou seja posso estabelecer as regras atras das barras do meu grafico
            }
            //definindo um tamanho para o gráfico
            .frame(height: 180)
            //se quiser personalizar somente o eixo X para exibir por exemplo todos os dados em vez de pular de 2 em 2 ou 3.. e outras personalizacoes apenas do X
            .chartXAxis{
                AxisMarks(values: viewDados.map { $0.date }) { date in
//                    AxisGridLine() //adiciona linhas como uma grade
//                    AxisTick() //as linhas ultrapassam para fora do grafico para chegar no eixo X
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true) //aqui posso mudar de .year para .month dependendo do que quero mostrar e posso centralizar com o 'centered'
                }
            }
            
            // Pode realizar as mesmas personalizaxcoes ou ate mais somente com o eixo Y:
            .chartYAxis{
//                AxisMarks(position: .leading) //isso muda as informacoes do eixo y para a esquerda
                AxisMarks{ mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
                
            }
            
//            //quando quiser um intervalo especifico sem ser o do padrao:
//            .chartYScale(domain: 0...2000)
            
//            //qunado quiser ocultar as informacoes:
//            .chartXAxis(.hidden) //oculta as info do eixo X
//            .chartYAxis(.hidden) //oculta as info do eixo Y
            
            //personalizando o fundo do grafico:
//            .chartPlotStyle { plotContent in
//                plotContent
//                    .background(Color(.systemGray6))
//                    .border(.green, width: 3) //borda do gráfico
//                
//            }
            //adicionando tipo uma anotacao
            .padding(.bottom) //deixa mais separado a descrição
            HStack{
                Image(systemName: "line.diagonal") //simbolo
                    .rotationEffect(Angle(degrees: 45)) //virando o simbolo
                    .foregroundColor(.mint)
                
                Text("Montantes Totais") //exemplo de descricao
                    .foregroundColor(.secondary)
            }
            .font(.caption2)
            .padding(.leading, 4)
        }
        .padding()
    }
}

struct ViewDado: Identifiable {
    let id = UUID() //digamos que o ID recebe UU e depois ele vai receber os 
    let date: Date //eixo X das datas das noticias
    let viewCount: Int //eixo Y de dados aleatorios
}

extension Date { //extensao para exibir a data com base naquele ano, mes, dia que eu passo.
    static func from(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents() //depois crio um objeto com base naqueles dados que passei
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
