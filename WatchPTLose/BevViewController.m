//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "BevViewController.h"
#import "PTService.h"
#import "ThemeService.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

@interface BevViewController ()

@end

@implementation BevViewController {
    PTService *_service;
    ThemeService *_theme;
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
}

@end
