#import <XCTest/XCTest.h>

#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "TimeHelper.h"
#import "FourHourWeekAchievement.h"
#import "DateHelper.h"

@interface FourHourWeekAchievementTests : XCTestCase

@end

@implementation FourHourWeekAchievementTests

- (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testDetects36HoursIn5ConsecutiveDays {
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-01-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-02-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-03-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-04-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-05-2015"] seconds:@([TimeHelper hoursInSeconds:4]) reason:@""]];

    XCTAssertTrue([[FourHourWeekAchievement new] achieved]);
}

- (void)testDoesNotDetect35HoursIn5ConsecutiveDays {
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-01-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-02-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-03-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-04-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-05-2015"] seconds:@([TimeHelper hoursInSeconds:3]) reason:@""]];

    XCTAssertFalse([[FourHourWeekAchievement new] achieved]);
}

- (void)testDoesNotDetect36HoursIn5NonConsecutiveDays {
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-01-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-02-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-03-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-04-2015"] seconds:@([TimeHelper hoursInSeconds:8]) reason:@""]];

    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord                                                    recordWithDate:
                    [[DateHelper monthDayYearFormatter] dateFromString:@"03-05-2015"] seconds:@([TimeHelper hoursInSeconds:3]) reason:@""]];

    XCTAssertFalse([[FourHourWeekAchievement new] achieved]);
}

@end