//
//  ForecastAPIService.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "ForecastAPIService.h"
#import <AFNetworking/AFNetworking.h>
#import "City.h"
#import "Forecast.h"

NSString * const appID = @"your_weather_api_client_secret";
NSString * const forecastLink = @"http://api.openweathermap.org/data/2.5/forecast?q=%@&units=%@&mode=json&APPID=%@";
//metric

@implementation ForecastAPIService

- (void)getCityAndForecastsWithCityName:(NSString *)cityName unit:(NSString *)unit success:(successResponse)success failure:(failureResponse)failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSString *path = [NSString stringWithFormat:forecastLink, cityName, unit, appID];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error;
        City *city = [MTLJSONAdapter modelOfClass:[City class] fromJSONDictionary:responseObject[@"city"] error:&error];
        NSArray *forecasts = [MTLJSONAdapter modelsOfClass:[Forecast class] fromJSONArray:responseObject[@"list"] error:&error];

        NSDictionary *responseObjects = @{@"city" : city,
                                          @"forecasts" : forecasts};
        success(responseObjects);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
