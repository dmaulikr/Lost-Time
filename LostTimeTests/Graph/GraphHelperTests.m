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

- (void)testSetsDatesAndSecondsInDataSeries {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord recordWithDate:[formatter dateFromString:@"03-15-2015"] seconds:@1000 reason:@"bob"]];
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord recordWithDate:[formatter dateFromString:@"03-17-2015"] seconds:@2000 reason:@"bob"]];
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord recordWithDate:[formatter dateFromString:@"03-18-2015"] seconds:@3000 reason:@"bob"]];

    NSArray *data = [GraphHelper graphDataByReason];
    XCTAssertEqual([data[0][@"data"] count], 3);
    XCTAssertEqual([data[0][@"data"][0] count], 2);

    XCTAssertEqualObjects(data[0][@"data"][0][1], @1000);
    XCTAssertEqualObjects(data[0][@"data"][1][1], @2000);
    XCTAssertEqualObjects(data[0][@"data"][2][1], @3000);

    XCTAssertEqualObjects(data[0][@"data"][0][0], @1426392000);
    XCTAssertEqualObjects(data[0][@"data"][1][0], @1426564800);
    XCTAssertEqualObjects(data[0][@"data"][2][0], @1426651200);

}

@end