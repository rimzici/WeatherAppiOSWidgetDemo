//
//  WidgetModuleBridge.m
//  WeatherApp
//
//  Created by Rimnesh Fernandez on 06/11/20.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(WeatherWidgetModule, NSObject)

RCT_EXTERN_METHOD(setWidgetData:(NSDictionary *))
RCT_EXTERN_METHOD(refreshAllWidgets)

@end
