#import "StartTimeDataStore.h"

@implementation StartTimeDataStore

+ (void)saveStartTime:(double)timeIntervalSinceEpoch {
    [[NSUserDefaults standardUserDefaults] setDouble:timeIntervalSinceEpoch forKey:@"startTime"];
}

+ (void)clearStoredTime {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startTime"];
}

+ (BOOL)hasStoredStartTime {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"startTime"] == 0;
}

+ (NSTimeInterval)loadStartTime {
    NSTimeInterval interval = [[NSUserDefaults standardUserDefaults] doubleForKey:@"startTime"];
    return interval;
}

@end