//
//  Forecast.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "Forecast.h"
#import "Weather.h"

@implementation Forecast

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    
    return @{
             @"unixTime" : @"dt",
             
             @"currentTemperature" : @"main.temp",
             @"minTemperature" : @"main.temp_min",
             @"maxTemperature" : @"main.temp_max",
             
             @"weatherList" : @"weather"};
}

+ (NSValueTransformer *)weatherListJSONTransformer {
    
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Weather class]];
}

- (NSDate*)time {
    
    return [NSDate dateWithTimeIntervalSince1970:[self.unixTime doubleValue]];
}
@end
