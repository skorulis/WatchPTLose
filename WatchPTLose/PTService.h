//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Foundation/Foundation.h>
#import "GambleRecord.h"
#import "BevRecord.h"
#import <UIKit/UIKit.h>

static NSString * const kChangeNotification = @"kChangeNotification";

@interface PTService : NSObject

+ (PTService *)sharedInstance;

- (void)addWin:(NSInteger)amount;
- (void)addPTBev;
- (void)addSKBev;

- (NSArray<GambleRecord *>*)allRecords;
- (NSArray<BevRecord *> *)allDrinks;
- (NSInteger)totalWin;
- (NSInteger)skBevCount;
- (NSInteger)ptBevCount;

- (UIImage *)imageForAmount:(NSInteger)amount;
- (UIImage *)instantImageForAmount:(NSInteger)amount;
- (void)deleteBetAtIndex:(NSInteger)index;
- (void)deleteDrinkAtIndex:(NSInteger)index;

@end
