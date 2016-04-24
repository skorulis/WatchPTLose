//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "EventListViewController.h"
#import "PTService.h"
#import "ThemeService.h"
#import <Masonry/Masonry.h>

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
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"events" image:nil tag:0];
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
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service allRecords].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GambleRecord *record = _service.allRecords[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"$%d",(int)ABS(record.amount)];
    cell.textLabel.textColor = [_theme colorForAmount:record.amount];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:record.timestamp];
    cell.detailTextLabel.text = [_dateFormat stringFromDate:date];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_service deleteItemAtIndex:indexPath.row];
}

- (void)change:(id)sender {
    [_tableView reloadData];
}

@end
