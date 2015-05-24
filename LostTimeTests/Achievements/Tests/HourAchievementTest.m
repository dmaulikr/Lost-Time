#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "HourAchievement.h"

@interface HourAchievementTest : XCTestCase
@end

@implementation HourAchievementTest

- (void)setUp {
    [[LostTimeDataStore instance] empty];
}

- (void)testTriggersAfterOneHourOnAGivenDay {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@2600 reason:@""]];
    XCTAssertFalse([[HourAchievement new] achieved]);

    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1000 reason:@""]];
    XCTAssertTrue([[HourAchievement new] achieved]);
}

@end