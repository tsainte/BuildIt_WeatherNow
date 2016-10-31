//
//  ForecastViewController.m
//  WeatherNow
//
//  Created by Tiago Bencardino on 31/10/2016.
//  Copyright © 2016 TheWeatherNow. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastViewModel.h"
#import "CityTableViewCell.h"
#import "ForecastTableViewCell.h"
#import "UIImageView+AFNetworking.h"

NSInteger const citySection = 0;
NSInteger const forecastSection = 1;

NSString * const cityTableViewCellKey = @"CityTableViewCell";
NSString * const forecastTableViewCellKey = @"ForecastTableViewCell";

@interface ForecastViewController ()

@property (nonatomic, strong) ForecastViewModel *viewModel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ForecastViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addObservers];
    [self configureViewModel];
    [self configureTableView];
    
    [self fetchData];
}

- (void)dealloc {
    
    [self removeObservers];
}

- (void)configureViewModel {
    
    self.viewModel = [ForecastViewModel new];
}

- (void)viewDidLayoutSubviews {
    
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
}

- (void)configureTableView {
    
    [self.tableView registerNib:[UINib nibWithNibName:cityTableViewCellKey bundle:nil] forCellReuseIdentifier:cityTableViewCellKey];
    [self.tableView registerNib:[UINib nibWithNibName:forecastTableViewCellKey bundle:nil] forCellReuseIdentifier:forecastTableViewCellKey];
    
    self.tableView.estimatedRowHeight = 76;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)fetchData {
    
    [self.viewModel fetchData];
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows = 0;
    switch (section) {
        case citySection:
            numberOfRows = 1;
            break;
        case forecastSection:
            numberOfRows = [self.viewModel countForecast];
            break;
        default:
            numberOfRows = 0;
            break;
    }
    return numberOfRows;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case citySection:
            cell = [self cityCell];
            break;
        case forecastSection:
            cell = [self forecastCellForRow:indexPath.row];
            break;
        default:
            cell = [UITableViewCell new];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell*)cityCell {
    
    CityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cityTableViewCellKey];
    
    //Async image downloader with image cache category from AFNetworking
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[self.viewModel countryFlagURL]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [cell.flagImageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];
    cell.nameLabel.text = [self.viewModel cityName];
    
    return cell;
}

- (UITableViewCell*)forecastCellForRow:(NSInteger)row {
    
    ForecastTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:forecastTableViewCellKey];
    
    //Async image downloader with image cache category from AFNetworking
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[self.viewModel weatherIconURLForRow:row]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [cell.iconImageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];
    cell.descriptionLabel.text = [self.viewModel weatherDescriptionForRow:row];
    cell.maxTemperatureLabel.text = [self.viewModel maxTemperatureForRow:row];
    cell.minTemperatureLabel.text = [self.viewModel minTemperatureForRow:row];
    cell.formattedDateLabel.text = [self.viewModel readableDateForRow:row];
    
    return cell;
}

#pragma mark - refresh

- (void)refresh {
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)refreshFailed:(NSNotification*)notification {
    
    NSString *errorMessage = notification.object;
    [self.refreshControl endRefreshing];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Observers

- (void)addObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:forecastListDidChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFailed:) name:forecastListDidFailed object:nil];
}

- (void)removeObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:forecastListDidChanged object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:forecastListDidFailed object:nil];
}
@end
