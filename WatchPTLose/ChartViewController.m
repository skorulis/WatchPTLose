//
//  ChartViewController.m
//  WatchPTLose
//
//  Created by Alexander Skorulis on 24/4/17.
//  Copyright © 2017 Alex Skorulis. All rights reserved.
//

#import "ChartViewController.h"
#import "PTService.h"
#import "DateValueFormatter.h"
@import Charts;
@import FontAwesomeKit;
@import Masonry;

@interface ChartViewController () {
    LineChartView *_chartView;
    PTService *_service;
}

@end

@implementation ChartViewController

- (instancetype)init {
    self = [super init];
    FAKIcon *icon = [FAKFontAwesome barChartIconWithSize:24];
    UIImage *image = [icon imageWithSize:CGSizeMake(30, 30)];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"charts" image:image tag:0];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chart";
    _service = [PTService sharedInstance];
    
    _chartView = [[LineChartView alloc] initWithFrame:CGRectZero];
    //_colors = @[[UIColor blueColor],[UIColor redColor],[UIColor grayColor],[UIColor orangeColor],[UIColor purpleColor]];
    [self.view addSubview:_chartView];
    
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.highlightPerDragEnabled = YES;
    
    _chartView.backgroundColor = UIColor.whiteColor;
    
    _chartView.legend.enabled = NO;
    
    /*ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTopInside;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.labelTextColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:56/255.0 alpha:1.0];
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawGridLinesEnabled = YES;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.valueFormatter = [[DateValueFormatter alloc] init];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.granularityEnabled = YES;
    leftAxis.yOffset = -9.0;
    leftAxis.labelTextColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:56/255.0 alpha:1.0];*/
    
    _chartView.rightAxis.enabled = NO;
    
    _chartView.legend.form = ChartLegendFormLine;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateChart];
}

- (void)updateChart {
    NSArray<GambleRecord *> *records = [_service allRecords];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *runningTotal = [[NSMutableArray alloc] init];
    CGFloat total = 0;
    for (NSInteger i = records.count-1; i >= 0; --i) {
        NSInteger index = records.count - i;
        GambleRecord *record = records[i];
        total += record.amount;
        ChartDataEntry *cde = [[ChartDataEntry alloc] initWithX:index y:record.amount];
        ChartDataEntry *cde2 = [[ChartDataEntry alloc] initWithX:index y:total];
        [values addObject:cde];
        [runningTotal addObject:cde2];
    }
    
    LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:values];
    dataSet.drawCirclesEnabled = NO;
    dataSet.lineWidth = 2;
    dataSet.drawValuesEnabled = NO;
    [dataSet setColor:[UIColor redColor]];
    
    LineChartDataSet *dataSet2 = [[LineChartDataSet alloc] initWithValues:runningTotal];
    [dataSet2 setColor:[UIColor blueColor]];
    dataSet2.drawCirclesEnabled = NO;
    dataSet2.drawFilledEnabled = YES;
    dataSet2.drawValuesEnabled = NO;
    dataSet2.lineWidth = 2;
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:@[dataSet2,dataSet]];
    _chartView.data = data;
    
}



@end
