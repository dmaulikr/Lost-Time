#import "HourAchievement.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@implementation HourAchievement

- (BOOL)achieved {
    NSMutableDictionary *secondsByDate = [@{} mutableCopy];
    for (LostTimeRecord *record in [[LostTimeDataStore instance] findAll]) {
        NSString *dayDateKey = [self dateKeyForDate: record.date];
        NSNumber *seconds = secondsByDate[dayDateKey];
        if (!seconds) {
            secondsByDate[dayDateKey] = record.seconds;
        }
        else {
            secondsByDate[dayDateKey] = @([seconds intValue] + [record.seconds intValue]);
        }
    }

    int secondsPerHour = 60 * 60;
    for (NSNumber *value in [secondsByDate allValues]) {
        if ([value intValue] >= secondsPerHour) {
            return YES;
        }
    }

    return NO;
}

- (NSString *)dateKeyForDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    return [formatter stringFromDate:date];
}

- (NSString *)achievementId {
    return @"hour";
}

@end