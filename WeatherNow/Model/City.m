//
//  City.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "City.h"

@implementation City

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    
    return @{
             @"ID" : @"id",
             
             @"country"  : @"country",
             @"latitude" : @"coord.lat",
             @"longitude" : @"coord.lon",
             @"name" : @"name"
             };
}

- (NSURL*)countryFlagURL {

    NSString *urlString = [NSString stringWithFormat:@"http://www.geonames.org/flags/x/%@.gif", [self.country lowercaseString]];
    return [NSURL URLWithString:urlString];
}

@end
