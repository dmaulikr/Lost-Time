#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "LostTimeDataStore.h"
#import "WorkDayInWeekAchievement.h"
#import "LostTimeRecord.h"

@interface WorkDayInWeekAchievementTests : XCTestCase
@end

@implementation WorkDayInWeekAchievementTests

- (void)setUp {
    [[LostTimeDataStore instance] empty];
}

- (void)testDoesNotFireForNoData {
    XCTAssertFalse([[WorkDayInWeekAchievement new] achieved]);
}

- (void)logHours:(int)hours onDate:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    const int SECONDS_PER_MINUTE = 60;
    const int MINUTES_PER_HOUR = 60;
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord recordWithDate:[formatter dateFromString:date]
                                   seconds:@(SECONDS_PER_MINUTE * MINUTES_PER_HOUR * hours) reason:@""]];
}

- (void)testDetectsOverA7DayPeriod {
    [self logHours:1 onDate:@"03-11-2015"];
    [self logHours:2 onDate:@"03-12-2015"];
    [self logHours:2 onDate:@"03-13-2015"];
    [self logHours:4 onDate:@"03-14-2015"];
    [self logHours:1 onDate:@"03-15-2015"];
    [self logHours:1 onDate:@"03-16-2015"];

    XCTAssertTrue([[WorkDayInWeekAchievement new] achieved]);
}

- (void)testDoesNotDetectOnNonSequentialDays {
    [self logHours:1 onDate:@"03-11-2015"];
    [self logHours:2 onDate:@"03-13-2015"];
    [self logHours:2 onDate:@"03-15-2015"];
    [self logHours:4 onDate:@"03-21-2015"];
    [self logHours:1 onDate:@"03-22-2015"];
    [self logHours:1 onDate:@"03-27-2015"];

    XCTAssertFalse([[WorkDayInWeekAchievement new] achieved]);
}

@end