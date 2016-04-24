//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "EventListViewController.h"
#import "PTService.h"
#import "ThemeService.h"
#import <Masonry/Masonry.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

@interface EventListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation EventListViewController {
    PTService *_service;
    ThemeService *_theme;
    NSDateFormatter *_dateFormat;
    UITableView *_tableView;
}

- (instancetype)init {
    self = [super init];
    _service = [PTService sharedInstance];
    _theme = [ThemeService sharedInstance];
    _dateFormat = [[NSDateFormatter alloc] init];
    _dateFormat.dateFormat = @"HH:mm";
    FAKIcon *icon = [FAKFontAwesome listOlIconWithSize:24];
    UIImage *image = [icon imageWithSize:CGSizeMake(30, 30)];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"events" image:image tag:0];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 40;
    [self.view addSubview:_tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:kChangeNotification object:nil];
    [self buildLayout];
}

- (void)buildLayout {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(20);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [_service allRecords].count : _service.allDrinks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        GambleRecord *record = _service.allRecords[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"$%d",(int)ABS(record.amount)];
        cell.textLabel.textColor = [_theme colorForAmount:record.amount];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:record.timestamp];
        cell.detailTextLabel.text = [_dateFormat stringFromDate:date];
        return cell;
    } else {
        BevRecord *bev = _service.allDrinks[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ bev",bev.person];
        NSInteger amount = [bev.person isEqualToString:@"skorulis"] ? -1 : 1;
        cell.textLabel.textColor = [_theme colorForAmount:amount];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:bev.timestamp];
        cell.detailTextLabel.text = [_dateFormat stringFromDate:date];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"gambling" : @"beers";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [_service deleteBetAtIndex:indexPath.row];
    } else {
        [_service deleteDrinkAtIndex:indexPath.row];
    }
}

- (void)change:(id)sender {
    [_tableView reloadData];
}

@end
