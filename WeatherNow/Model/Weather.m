//
//  Weather.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "Weather.h"

@implementation Weather

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    
    return @{
             @"ID" : @"id",
             @"descriptionText" : @"description",
             @"icon" : @"icon",
             @"title" : @"main"
             };
}

- (NSURL*)iconURL {
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", self.icon]];
}

@end
