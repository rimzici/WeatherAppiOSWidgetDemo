//
//  WeatherWidgetModule.swift
//  WeatherApp
//
//  Created by Rimnesh Fernandez on 06/11/20.
//

import Foundation
import WidgetKit

@objc(WeatherWidgetModule)
class WeatherWidgetModule: NSObject {
  
  static let GroupId = "group.weather.app"
  
  @objc(setWidgetData:)
  func setWidgetData(widgetData: NSDictionary) -> Void {
    do {
      let fileManager = FileManager.default
      let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: WeatherWidgetModule.GroupId)
      guard let fileURL = directory?.appendingPathComponent("widgetData.json") else {
        return
      }
      try JSONSerialization.data(withJSONObject: widgetData)
        .write(to: fileURL)
    } catch {
    }
  }
  
  func getWidgetData() -> Dictionary<String, Any>? {
    var dictionary: Dictionary<String, Any>? = nil
    do {
      let fileManager = FileManager.default
      let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: WeatherWidgetModule.GroupId)
      guard let fileURL = directory?.appendingPathComponent("widgetData.json") else {
        return dictionary
      }
      
      let data = try Data(contentsOf: fileURL)
      let json = try JSONSerialization.jsonObject(with: data)
      guard let _dictionary = json as? Dictionary<String, Any> else {
        return dictionary
      }
      dictionary = _dictionary
    } catch {
    }
    return dictionary
  }
  
  @objc(refreshAllWidgets)
  func refreshAllWidgets() {
    if #available(iOS 14.0, *) {
      WidgetCenter.shared.reloadAllTimelines()
    }
  }
}
