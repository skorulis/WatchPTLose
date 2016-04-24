//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "GambleRecord.h"

@implementation GambleRecord

- (instancetype)initWithDate:(NSDate *)date amount:(NSInteger)amount {
    self = [super init];
    _date = date;
    _amount = amount;
    return self;
}

@end
