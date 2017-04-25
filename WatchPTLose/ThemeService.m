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

- (UIImage *)upButtonBackground {
    UIColor *c = [self colorForAmount:1];
    return [ThemeService imageFromColor:c size:CGSizeMake(1, 1)];
}

- (UIImage *)downButtonBackground {
    UIColor *c = [self colorForAmount:-1];
    return [ThemeService imageFromColor:c size:CGSizeMake(1, 1)];
}

- (UIImage *)greyButtonBackground {
    UIColor *c = [UIColor grayColor];
    return [ThemeService imageFromColor:c size:CGSizeMake(1, 1)];
}

+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size {
    NSAssert(size.width > 0 && size.height > 0,@"Attempt to create image context with size %@",NSStringFromCGSize(size));
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
