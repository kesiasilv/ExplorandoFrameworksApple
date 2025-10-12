//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Késia Silva Viana on 11/10/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date())
    }
    
    
    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for  dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: entryDate)
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
}

//aqui que montamos a vizualizacao onde tem o corpo do widget
struct MonthlyWidgetEntryView : View {
    var entry: Provider.Entry
    var config: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        ZStack{
            //            ContainerRelativeShape()
            //                .fill(.gray.gradient)
            VStack{
                HStack(spacing: 4) {
                    Text(config.emojiText)
                        .font(.title)
                    Text(entry.date.formatted(.dateTime.weekday(.wide)))
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(config.dayTextColor)
                    Spacer()
                }
                Text(entry.date.formatted(.dateTime.day()))
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundColor(config.dayTextColor)
            }
            //            .padding()
            
        }
    }
}

//Aqui que passamos os dados e os tipos, pois temos uma struct do tipo Widget..
struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"
    var config: MonthConfig = MonthConfig.determineConfig(from: Date())
    
    var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: Provider()) { entry in
                if #available(iOS 17.0, *) {
                    MonthlyWidgetEntryView(entry: entry)
                        .containerBackground(config.backgroundColor.gradient ,for: .widget)
                } else {
                    MonthlyWidgetEntryView(entry: entry)
                        .background(
                            ContainerRelativeShape()
                                .fill(config.backgroundColor.gradient)
                            
                        )
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
    DayEntry(date: .now)
    DayEntry(date: .now)
}
