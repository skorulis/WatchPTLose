//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import <Foundation/Foundation.h>

@interface GambleRecord : NSObject

@property (nonatomic,readonly) NSDate *date;
@property (nonatomic,readonly) NSInteger amount;

- (instancetype)initWithDate:(NSDate *)date amount:(NSInteger)amount;

@end
