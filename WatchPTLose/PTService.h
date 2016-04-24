//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Foundation/Foundation.h>
#import "GambleRecord.h"
#import <UIKit/UIKit.h>

static NSString * const kChangeNotification = @"kChangeNotification";

@interface PTService : NSObject

+ (PTService *)sharedInstance;

- (void)addWin:(NSInteger)amount;
- (NSArray<GambleRecord *>*)allRecords;
- (NSInteger)totalWin;
- (UIImage *)imageForAmount:(NSInteger)amount;
- (void)deleteItemAtIndex:(NSInteger)index;

@end
