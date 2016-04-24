//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface GambleRecord : MTLModel <MTLJSONSerializing>

@property (nonatomic,readonly) NSTimeInterval timestamp;
@property (nonatomic,readonly) NSInteger amount;

- (instancetype)initWithDate:(NSTimeInterval)date amount:(NSInteger)amount;

@end
