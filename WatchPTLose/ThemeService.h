//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ThemeService : NSObject

+ (ThemeService *)sharedInstance;
- (UIColor *)colorForAmount:(NSInteger)amount;
- (UIImage *)upButtonBackground;
- (UIImage *)downButtonBackground;
- (UIImage *)greyButtonBackground;

@end
