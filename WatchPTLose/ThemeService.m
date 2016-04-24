//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "ThemeService.h"

@implementation ThemeService

+ (ThemeService *)sharedInstance {
    static ThemeService *sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[ThemeService alloc] init];
    });
    return sharedService;
}

- (UIColor *)colorForAmount:(NSInteger)amount {
    if (amount < 0) {
        return  [UIColor colorWithRed:0.8 green:0.0 blue:0.1 alpha:1];
    } else {
        return [UIColor colorWithRed:0 green:0.8 blue:0.1 alpha:1];
    }
}

@end
