//
//  City.h
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface City : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *name;

//not in json
@property (nonatomic, strong) NSURL *countryFlagURL;

@end
