#import "WorkDayInWeekAchievement.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "DayHelper.h"
#import "TimeHelper.h"

@implementation WorkDayInWeekAchievement

- (BOOL)achieved {
    NSArray *records = [[LostTimeDataStore instance] findAll];
    for (NSUInteger i = 0; i < [records count]; i++) {
        LostTimeRecord *startRecord = records[i];
        int totalSeconds = [startRecord.seconds intValue];
        for (NSUInteger j = i + 1; j < [records count]; j++) {
            LostTimeRecord *currentRecord = records[j];
            int daysBetweenDates = [DayHelper daysBetweenDate:startRecord.date andDate:currentRecord.date];
            if (daysBetweenDates >= 7) {
                break;
            }
            totalSeconds += [currentRecord.seconds intValue];
            if (totalSeconds >= [TimeHelper secondsInHours:8]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSString *)achievementId {
    return @"workday";
}

@end