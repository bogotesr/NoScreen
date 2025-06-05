//
//  homeWidget.swift
//  homeWidget
//
//  Created by Joshua Laymon on 6/3/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), apps: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let apps = loadAppList()
        let entry = SimpleEntry(date: Date(), apps: apps)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let apps = loadAppList()
        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, apps: apps)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let apps: [AppList]
}

struct homeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            VStack {
                ForEach(entry.apps.prefix(5), id: \.name) {app in
                    Link(destination: URL(string: "\(app.scheme)")!) {
                        Text(app.name)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 3.0)
                }
            }
            .padding(.bottom, 70)
        }
    }
}

struct homeWidget: Widget {
    let kind: String = "homeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                homeWidgetEntryView(entry: entry)
                    .containerBackground(Color("dockColor"), for: .widget)
            } else {
                homeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Apps Page")
        .description("This page has your main apps.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    homeWidget()
} timeline: {
    SimpleEntry(date: .now, apps: [
        AppList(id: 1, name: "Discord", scheme: "discord", enabled: false, position: 2),
        AppList(id: 2, name: "Messages", scheme: "messages", enabled: false, position: 1)
    ])
}
