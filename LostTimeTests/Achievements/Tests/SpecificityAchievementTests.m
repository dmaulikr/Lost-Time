#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "SpecificityAchievement.h"

@interface SpecificityAchievementTests : XCTestCase
@end

@implementation SpecificityAchievementTests

- (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testDetectsCustomLogMessages {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@0 reason:@"a"]];
    XCTAssertTrue([[SpecificityAchievement new] achieved]);
}

- (void)testDoesNotTriggerForBlankReasons {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@0 reason:@""]];
    XCTAssertFalse([[SpecificityAchievement new] achieved]);
}

- (void)testDoesNotTriggerForStockReasons {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@0 reason:@"commute"]];
    XCTAssertFalse([[SpecificityAchievement new] achieved]);
}

@end