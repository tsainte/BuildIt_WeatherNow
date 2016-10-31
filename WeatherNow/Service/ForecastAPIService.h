//
//  ForecastAPIService.h
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successResponse)(id object);
typedef void(^failureResponse)(NSError *error);

@interface ForecastAPIService : NSObject

- (void)getCityAndForecastsWithCityName:(NSString*)cityName unit:(NSString*)unit success:(successResponse)success failure:(failureResponse)failure;

@end
