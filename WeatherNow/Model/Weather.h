//
//  Weather.h
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Weather : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *icon;

//not in json
@property (nonatomic, strong) NSURL *iconURL;

@end
