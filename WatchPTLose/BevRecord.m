//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "BevRecord.h"

@implementation BevRecord

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

- (instancetype)initWithDate:(NSTimeInterval)date person:(NSString *)person {
    self = [super init];
    _timestamp = date;
    _person = person;
    return self;
}


@end
