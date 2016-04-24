//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Mantle/Mantle.h>

@interface BevRecord : MTLModel <MTLJSONSerializing>

@property (nonatomic,readonly) NSTimeInterval timestamp;
@property (nonatomic,readonly) NSString *person;

- (instancetype)initWithDate:(NSTimeInterval)date person:(NSString *)person;

@end
