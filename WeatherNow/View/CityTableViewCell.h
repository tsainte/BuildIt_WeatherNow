//
//  CityTableViewCell.h
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
