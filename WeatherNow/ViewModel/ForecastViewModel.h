//
//  ForecastViewModel.h
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const forecastListDidChanged;
extern NSString * const forecastListDidFailed;

@interface ForecastViewModel : NSObject

- (NSInteger)countForecast;
- (void)fetchData;

#pragma mark - city binding
- (NSURL*)countryFlagURL;
- (NSString*)cityName;

#pragma mark - forecast binding
- (NSURL*)weatherIconURLForRow:(NSInteger)row;
- (NSString*)weatherDescriptionForRow:(NSInteger)row;
- (NSString*)minTemperatureForRow:(NSInteger)row;
- (NSString*)maxTemperatureForRow:(NSInteger)row;
- (NSString*)readableDateForRow:(NSInteger)row;

@end
