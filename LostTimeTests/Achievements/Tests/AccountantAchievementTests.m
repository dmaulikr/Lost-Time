#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "AccountantAchievement.h"

@interface AccountantAchievementTests : XCTestCase
@end

@implementation AccountantAchievementTests

- (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testDetectsFor10Entries {
    for (int i = 0; i < 10; i++) {
        [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@0 reason:@""]];
    }
    XCTAssertTrue([[AccountantAchievement new] achieved]);
}

- (void)testDoesNotDetectFor9Entries {
    for (int i = 0; i < 9; i++) {
        [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@0 reason:@""]];
    }
    XCTAssertFalse([[AccountantAchievement new] achieved]);
}

@end