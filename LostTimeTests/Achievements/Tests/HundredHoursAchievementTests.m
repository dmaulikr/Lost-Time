#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "HundredHoursAchievement.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "TimeHelper.h"

@interface HundredHoursAchievementTests : XCTestCase
@end

@implementation HundredHoursAchievementTests

- (void) setUp{
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testDoesNotTrigger99Hours {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@(
            [TimeHelper hoursInSeconds:99]
    )                                                              reason:@""]];
    XCTAssertFalse([[HundredHoursAchievement new] achieved]);
}

- (void)testTriggers100Hours {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@(
            [TimeHelper hoursInSeconds:100]
    )                                                              reason:@""]];
    XCTAssertFalse([[HundredHoursAchievement new] achieved]);
}

@end