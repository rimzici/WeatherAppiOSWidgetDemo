//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Rimnesh Fernandez on 06/11/20.
//

import WidgetKit
import SwiftUI
import Intents

let label: String = "Humidity"
struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(
      date: Date(),
      provider: "",
      label: label,
      value: "",
      configuration: ConfigurationIntent())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(
      date: Date(),
      provider: "",
      label: label,
      value: "",
      configuration: configuration)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    var value: String = ""
    var providerName: String = ""
    let providerId = configuration.provider?.identifier
    let widgetData = WeatherWidgetModule().getWidgetData()
    if providerId != nil, widgetData != nil {
      let provider =  widgetData![providerId!] as? Dictionary<String, Any>
      let values = provider!["values"]! as? Dictionary<String, Any>
      let units = provider!["units"]! as? Dictionary<String, Any>
      providerName = (provider!["providerName"]! as? String)!
      value = "\((values!["humidity"] as? String)!) \((units!["humidity"] as? String)!)"
    }
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(
        date: entryDate,
        provider: providerName,
        label: label,
        value: value,
        configuration: configuration
      )
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  var date: Date
  var provider: String
  var label: String
  var value: String
  let configuration: ConfigurationIntent
}

struct WeatherWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    return VStack {
      Text(entry.provider).font(.headline).multilineTextAlignment(.center)
      Text(entry.label).font(.caption).multilineTextAlignment(.center)
      Text(entry.value)
      Text(Date(), style: .relative)
        .multilineTextAlignment(.center)
    }
    .widgetURL(URL(string: "widget-deeplink://WidgetScreen"))
  }
}

@main
struct WeatherWidget: Widget {
  let kind: String = "WeatherWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      WeatherWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}

struct WeatherWidget_Previews: PreviewProvider {
  static var previews: some View {
    WeatherWidgetEntryView(entry: SimpleEntry(
                            date: Date(),
                            provider: "",
                            label: label,
                            value: "",
                            configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
