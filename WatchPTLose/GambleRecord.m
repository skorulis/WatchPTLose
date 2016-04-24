//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "GambleRecord.h"

@implementation GambleRecord

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

- (instancetype)initWithDate:(NSTimeInterval)date amount:(NSInteger)amount {
    self = [super init];
    _timestamp = date;
    _amount = amount;
    return self;
}

@end
