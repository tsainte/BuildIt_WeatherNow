//
//  Forecast.h
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Forecast : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *unixTime;
@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) NSNumber *currentTemperature;
@property (nonatomic, strong) NSNumber *minTemperature;
@property (nonatomic, strong) NSNumber *maxTemperature;

@property (nonatomic, strong) NSArray *weatherList;

@end
