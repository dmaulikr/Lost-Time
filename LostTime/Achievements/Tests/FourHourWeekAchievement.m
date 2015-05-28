#import "FourHourWeekAchievement.h"
#import "LostTimeRecord.h"
#import "LostTimeDataStore.h"
#import "DayHelper.h"
#import "TimeHelper.h"

@implementation FourHourWeekAchievement

- (BOOL)achieved {
    NSArray *records = [[LostTimeDataStore instance] findAll];
    for (NSUInteger i = 0; i < [records count]; i++) {
        LostTimeRecord *startRecord = records[i];
        int totalSeconds = [startRecord.seconds intValue];
        for (NSUInteger j = i + 1; j < [records count]; j++) {
            LostTimeRecord *currentRecord = records[j];
            int daysBetweenDates = [DayHelper daysBetweenDate:startRecord.date andDate:currentRecord.date];
            if (daysBetweenDates >= 5) {
                break;
            }
            totalSeconds += [currentRecord.seconds intValue];
            if (totalSeconds >= [TimeHelper hoursInSeconds:36]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSString *)achievementId {
    return @"4hour";
}

@end