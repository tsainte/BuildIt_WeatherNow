//
//  NSError+ErrorMessage.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "NSError+ErrorMessage.h"

@implementation NSError (ErrorMessage)

- (NSString*)errorMessage {
    
    NSInteger statusCode = self.code;
    NSString *errorMessage;
    
    if(statusCode == -1001) {
        errorMessage = @"Connection timeout. Please check your connection and try it again.";
    } else if (statusCode == -1009 || statusCode == -1004) {
        errorMessage = @"The Internet connection appears to be offline. Please check your connection and try it again.";
    } else {
        errorMessage = @"Oops, something went wrong and it's not your fault.";
    }
    return errorMessage;
}
@end
