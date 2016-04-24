//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Foundation/Foundation.h>
#import "GambleRecord.h"

@interface PTService : NSObject

- (void)addWin:(NSInteger)amount;
- (NSArray<GambleRecord *>*)allRecords;
- (NSInteger)totalWin;

@end
