//
//  WeatherWidgetModule.swift
//  WeatherApp
//
//  Created by Rimnesh Fernandez on 06/11/20.
//

import Foundation

@objc(WeatherWidgetModule)
class WeatherWidgetModule: NSObject {

  @objc(setWidgetData:)
  func setWidgetData(widgetData: NSArray) -> Void {
    print("TEST widgetData", widgetData)
  }
}
