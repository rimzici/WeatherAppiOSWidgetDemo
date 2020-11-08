//
//  IntentHandler.swift
//  WeatherWidgetIntentExtension
//
//  Created by Rimnesh Fernandez on 07/11/20.
//

import Intents

class IntentHandler: INExtension {
  
  override func handler(for intent: INIntent) -> Any {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self
  }
  
}

extension IntentHandler: ConfigurationIntentHandling {
  func provideProviderOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<ProvidersList>?, Error?) -> Void) {
    
    var items: Array<ProvidersList> = []
    var list: INObjectCollection<ProvidersList>? = INObjectCollection(items: items)
    guard let widgetData = WeatherWidgetModule().getWidgetData() else {
      completion(list, nil)
      return
    }
    for provider in widgetData.values {
      let _provider = provider as? Dictionary<String, Any>
      let identifier = _provider!["providerId"] as? Int
      let display = _provider!["providerName"] as? String
      items.append(
        ProvidersList(identifier: String(identifier!), display: display!)
      )
    }
    list = INObjectCollection(items: items)
    completion(list, nil)
  }
}
