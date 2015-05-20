#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "GraphHelper.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@interface GraphHelperTests : XCTestCase
@end

@implementation GraphHelperTests

+ (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testExportsLogReasonsAsSeries {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@1000 reason:@"bob"]];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@2000 reason:@"bob"]];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@3600 reason:@"commute"]];

    NSArray *data = [GraphHelper graphDataByReason];
    XCTAssertEqual([data count], 2);
    XCTAssertEqualObjects(data[0][@"name"], @"commute");
    XCTAssertEqualObjects(data[1][@"name"], @"bob");
}

@end