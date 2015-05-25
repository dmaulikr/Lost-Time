#import "ConsistencyAchievementTests.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "ConsistencyAchievement.h"

@implementation ConsistencyAchievementTests

- (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testDoesNotTrigger9OfSameType {
    for (int i = 0; i < 9; i++) {
        [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1 reason:@"a"]];
        [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1 reason:@"b"]];
    }

    XCTAssertFalse([[ConsistencyAchievement new] achieved]);
}

- (void)testDoesTriggers10OfSameType {
    for (int i = 0; i < 9; i++) {
        [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1 reason:@"a"]];
        [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1 reason:@"b"]];
    }
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1 reason:@"a"]];

    XCTAssertTrue([[ConsistencyAchievement new] achieved]);
}

@end