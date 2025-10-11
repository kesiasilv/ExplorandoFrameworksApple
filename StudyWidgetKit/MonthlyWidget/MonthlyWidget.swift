//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Késia Silva Viana on 11/10/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //o placeholder: Retorna uma entrada de linha do tempo simples e rápida. É usada para a visualização inicial do widget na galeria, antes que o usuário o adicione à tela inicial.
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), emoji: "😀")
    }
    
    //o getSnapshot: Fornece uma única entrada de linha do tempo com dados mais realistas. É chamada para gerar a pré-visualização do widget e permite um pouco mais de tempo para buscar dados de forma assíncrona.
    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
//o getTimeline: É o método principal. Ele gera uma Timeline, que é uma sequência de uma ou mais TimelineEntrys, cada uma com uma data e os dados que o widget deve exibir naquele momento. Também especifica a política de atualização, indicando quando o sistema deve solicitar uma nova linha do tempo.
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for  dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

//aqui adicinamos a entrada de dados que ira ter no widgets
struct DayEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

//aqui que montamos a vizualizacao onde tem o corpo do widget
struct MonthlyWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        ZStack{
//            ContainerRelativeShape()
//                .fill(.gray.gradient)
            VStack{
                HStack(spacing: 4){
                    Text(entry.emoji)
                        .font(.title)
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(.black.opacity(0.6))
                    Spacer()
                }
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundStyle(.white.opacity(0.8))
            }
//            .padding()
          
        }
    }
}

//Aqui que passamos os dados e os tipos, pois temos uma struct do tipo Widget..
struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MonthlyWidgetEntryView(entry: entry)
                    .containerBackground(.gray.gradient, for: .widget)
            } else {
                MonthlyWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Monthly Style Widget")
        .description("The theme of the widget changes based on month.")
        .supportedFamilies([.systemSmall])
    }
}

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String{
        self.formatted(.dateTime.day())
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: .now, emoji: "😃")
    DayEntry(date: .now, emoji: "🤩")
}
