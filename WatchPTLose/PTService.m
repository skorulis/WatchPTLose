//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "PTService.h"
#import <Underscore.m/Underscore.h>
static const NSInteger kMaxLose = -250;
static const NSInteger kMaxWin = 400;

@implementation PTService {
    NSMutableArray *_gambleRecords;
    NSArray *_faceImages;
    NSDictionary *_instantFaceMapping;
}

+ (PTService *)sharedInstance {
    static PTService *sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[PTService alloc] init];
    });
    return sharedService;
}

- (instancetype)init {
    self = [super init];
    NSString *path = [NSString stringWithFormat:@"%@/gamble.json",[PTService appDocumentsDirectoryPath]];
    NSData *gambleData = [NSData dataWithContentsOfFile:path];
    if (gambleData) {
        NSArray *json = [NSJSONSerialization JSONObjectWithData:gambleData options:0 error:nil];
        _gambleRecords = [MTLJSONAdapter modelsOfClass:[GambleRecord class] fromJSONArray:json error:nil].mutableCopy;
    } else {
        _gambleRecords = [[NSMutableArray alloc] init];
    }
    
    _faceImages = @[@"angry1",@"shocked1",@"angry2",@"0",@"1",@"shocked2",@"stoned1",@"stoned2",@"2",@"3",@"4",@"6",@"7",@"8",@"plain3",@"plain2",@"plain1",@"10",@"11",@"happy1",@"happy2",@"happy3",@"12",@"13",@"14",@"winning1",@"16",@"winning2",@"17"];
    
    _instantFaceMapping = @{@100 : @"winning2", @50 : @"winning1", @20 : @"happy2", @10 : @"10", @5 : @"11", @-100 : @"shocked1", @-50 : @"stoned1", @-20 : @"4", @-10 : @"2", @-5 : @"0"};
    
    return self;
}

- (void)addWin:(NSInteger)amount {
    GambleRecord *r = [[GambleRecord alloc] initWithDate:[NSDate date].timeIntervalSince1970 amount:amount];
    [_gambleRecords addObject:r];
    NSArray* json = [MTLJSONAdapter JSONArrayFromModels:_gambleRecords error:nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    NSString *path = [NSString stringWithFormat:@"%@/gamble.json",[PTService appDocumentsDirectoryPath]];
    [data writeToFile:path atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeNotification object:nil];
}

+ (NSString*) appDocumentsDirectoryPath {
    NSURL* url = [self applicationDocumentsDirectory];
    return [url.absoluteString substringFromIndex:7];
}

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
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

- (UIImage *)imageForAmount:(NSInteger)amount {
    float step = (kMaxWin - kMaxLose)/_faceImages.count;
    float total = kMaxLose;
    
    for (NSInteger i = 0; i < _faceImages.count; ++i) {
        if (total >= amount) {
            return [UIImage imageNamed:_faceImages[i]];
        }
        total += step;
    }
    return [UIImage imageNamed:@"17"];
}

- (UIImage *)instantImageForAmount:(NSInteger)amount {
    NSString *img = _instantFaceMapping[@(amount)];
    if (!img) {
        return [self imageForAmount:amount];
    }
    return [UIImage imageNamed:img];
}

- (void)deleteItemAtIndex:(NSInteger)index {
    [_gambleRecords removeObjectAtIndex:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeNotification object:nil];
}

@end
