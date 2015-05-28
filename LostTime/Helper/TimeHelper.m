#import "TimeHelper.h"

@implementation TimeHelper

const int SECONDS_PER_MINUTE = 60;
const int MINUTES_PER_HOUR = 60;

+ (int)secondsInHours:(int)hours {
    return hours * MINUTES_PER_HOUR * SECONDS_PER_MINUTE;
}

+ (int)secondsInHours:(int)hours minutes:(int)minutes {
    return hours * MINUTES_PER_HOUR * SECONDS_PER_MINUTE + minutes * SECONDS_PER_MINUTE;
}


@end