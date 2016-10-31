//
//  ForecastViewModel.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "ForecastViewModel.h"
#import "ForecastAPIService.h"
#import "City.h"
#import "Forecast.h"
#import "Weather.h"
#import "NSError+ErrorMessage.h"

NSString * const forecastListDidChanged = @"forecastListDidChanged";
NSString * const forecastListDidFailed = @"forecastListDidFailed";

@interface ForecastViewModel()

@property (nonatomic, strong) City *city;
@property (nonatomic, strong) NSArray *forecasts;

@property (nonatomic, strong) ForecastAPIService *api;
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) NSArray *mockCities;

@end

@implementation ForecastViewModel

- (id)init {
    
    if (self = [super init]) {
        self.api = [ForecastAPIService new];
        self.mockCities = @[@"London", @"Rio de Janeiro", @"New York", @"Berlin", @"Toronto", @"Tokyo", @"Lagos"];
    }
    
    return self;
}

- (NSDateFormatter*)formatter {
    
    if (!_formatter) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"EEEE, hh:mm a";
        _formatter = formatter;
    }
    
    return _formatter;
}

- (void)fetchData {
    
    NSUInteger randomIndex = arc4random() % [self.mockCities count];
    NSString *city = [self.mockCities[randomIndex] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    [self.api getCityAndForecastsWithCityName:city unit:@"metric" success:^(id result) {
        
        self.city = result[@"city"];
        self.forecasts = result[@"forecasts"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:forecastListDidChanged object:nil];
    } failure:^(NSError *error) {
        NSString *errorMessage = [error errorMessage];
        [[NSNotificationCenter defaultCenter] postNotificationName:forecastListDidFailed object:errorMessage];
    }];
}

- (NSInteger)countForecast {
    
    return self.forecasts.count;
}

#pragma mark - city binding

- (NSURL*)countryFlagURL {
    
    return self.city.countryFlagURL;
}
- (NSString*)cityName {
    
    return [self.city.name capitalizedString];
}

#pragma mark - forecast binding

- (NSURL*)weatherIconURLForRow:(NSInteger)row {
    
    Forecast *forecast = self.forecasts[row];
    Weather *weather = [forecast.weatherList firstObject];
    
    return [weather iconURL];
}
- (NSString*)weatherDescriptionForRow:(NSInteger)row {
    
    Forecast *forecast = self.forecasts[row];
    Weather *weather = [forecast.weatherList firstObject];
    
    return [weather descriptionText];
}

- (NSString*)minTemperatureForRow:(NSInteger)row {
    
    Forecast *forecast = self.forecasts[row];
    double minT = [forecast.minTemperature doubleValue];
    
    return [NSString stringWithFormat:@"%.0f °C", round(minT)];
}
- (NSString*)maxTemperatureForRow:(NSInteger)row {
    
    Forecast *forecast = self.forecasts[row];
    double maxT = [forecast.maxTemperature doubleValue];
    
    return [NSString stringWithFormat:@"%.0f °C", round(maxT)];
}

- (NSString*)readableDateForRow:(NSInteger)row {
    
    Forecast *forecast = self.forecasts[row];
    return [self.formatter stringFromDate:forecast.time];
}

@end
