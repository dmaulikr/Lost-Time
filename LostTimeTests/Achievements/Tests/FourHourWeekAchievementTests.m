#import <XCTest/XCTest.h>

#import "LostTimeDataStore.h"

@interface FourHourWeekAchievementTests : XCTestCase

@end

@implementation FourHourWeekAchievementTests

- (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testDetects4HoursIn5Days {
    XCTFail(@"implement this when not tired");
}

@end