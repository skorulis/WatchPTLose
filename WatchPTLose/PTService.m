//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "PTService.h"
#import <Underscore.m/Underscore.h>

@implementation PTService {
    NSMutableArray *_gambleRecords;
}

- (instancetype)init {
    self = [super init];
    _gambleRecords = [[NSMutableArray alloc] init];
    return self;
}

- (void)addWin:(NSInteger)amount {
    GambleRecord *r = [[GambleRecord alloc] initWithDate:[NSDate date] amount:amount];
    [_gambleRecords addObject:r];
    
}

- (NSInteger)totalWin {
    NSNumber *n = Underscore.array(_gambleRecords).reduce(@0, ^(NSNumber *x, GambleRecord *y) {
        return @(x.integerValue + y.amount);
    });
    return n.integerValue;
}

- (NSArray<GambleRecord *>*)allRecords {
    return _gambleRecords.copy;
}

@end
