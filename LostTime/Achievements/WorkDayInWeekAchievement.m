#import "WorkDayInWeekAchievement.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "DayHelper.h"

@implementation WorkDayInWeekAchievement

- (BOOL)achieved {
    const int EIGHT_HOURS_IN_SECONDS = 8 * 60 * 60;
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
            if (totalSeconds >= EIGHT_HOURS_IN_SECONDS) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSString *)achievementId {
    return @"workday";
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];

    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];

    return [difference day];
}

@end