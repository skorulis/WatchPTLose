//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "BevViewController.h"
#import "PTService.h"
#import "ThemeService.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Masonry/Masonry.h>

@interface BevViewController ()

@end

@implementation BevViewController {
    PTService *_service;
    ThemeService *_theme;
    UIButton *_meButton;
    UIButton *_ptButton;
}

- (instancetype)init {
    self = [super init];
    _service = [PTService sharedInstance];
    _theme = [ThemeService sharedInstance];
    
    FAKIcon *icon = [FAKFontAwesome beerIconWithSize:24];
    UIImage *image = [icon imageWithSize:CGSizeMake(34, 34)];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"non bever" image:image tag:0];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _meButton = [[UIButton alloc] init];
    [_meButton setTitle:@"skorulis bev" forState:UIControlStateNormal];
    [_meButton setBackgroundImage:_theme.downButtonBackground forState:UIControlStateNormal];
    [_meButton addTarget:self action:@selector(skorulisBev:) forControlEvents:UIControlEventTouchUpInside];
    _meButton.titleLabel.numberOfLines = 2;
    _meButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_meButton];
    
    _ptButton = [[UIButton alloc] init];
    [_ptButton setTitle:@"PT bev" forState:UIControlStateNormal];
    [_ptButton setBackgroundImage:_theme.upButtonBackground forState:UIControlStateNormal];
    [_ptButton addTarget:self action:@selector(ptBev:) forControlEvents:UIControlEventTouchUpInside];
    _ptButton.titleLabel.numberOfLines = 2;
    _ptButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_ptButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:kChangeNotification object:nil];
    [self buildLayout];
    [self change:nil];
}

- (void)buildLayout {
    [_meButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.6);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(-30);
    }];
    
    [_ptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.6);
        make.height.equalTo(@60);
        make.top.equalTo(self.view.mas_centerY).with.offset(30);
    }];
}

- (void)skorulisBev:(id)sender {
    [_service addSKBev];
}

- (void)ptBev:(id)sender {
    [_service addPTBev];
}

- (void)change:(id)sender {
    NSString *meTitle = [NSString stringWithFormat:@"skorulis bev\ntotal: %d",_service.skBevCount];
    NSString *ptTitle = [NSString stringWithFormat:@"PT bev\ntotal: %d",_service.ptBevCount];
    [_meButton setTitle:meTitle forState:UIControlStateNormal];
    [_ptButton setTitle:ptTitle forState:UIControlStateNormal];
}

@end
