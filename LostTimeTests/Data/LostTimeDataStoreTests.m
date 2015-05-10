#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "LostTimeRecord.h"
#import "LostTimeDataStore.h"

@interface LostTimeDataStoreTests : XCTestCase
@end

@implementation LostTimeDataStoreTests

- (void)testCanAddRecords {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@30 reason:@"tap on shoulder"]];
    XCTAssertEqual([[[LostTimeDataStore instance] findAll] count], 1U);
}

- (void)testCanEmptyRecords {
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[NSDate new] seconds:@30 reason:@"tap on shoulder"]];
    [[LostTimeDataStore instance] empty];
    XCTAssertEqual([[[LostTimeDataStore instance] findAll] count], 0U);
}

- (void)testCanFindRecordsByDate {
    LostTimeRecord *record1 = [LostTimeRecord recordWithDate:[[LostTimeRecord dateFormatter] dateFromString:@"2015-05-10T00:00:00-0000"] seconds:@0 reason:@""];
    LostTimeRecord *record2 = [LostTimeRecord recordWithDate:[[LostTimeRecord dateFormatter] dateFromString:@"2015-04-15T00:00:00-0000"] seconds:@0 reason:@""];
    LostTimeRecord *record3 = [LostTimeRecord recordWithDate:[[LostTimeRecord dateFormatter] dateFromString:@"2015-06-15T00:00:00-0000"] seconds:@0 reason:@""];
    LostTimeRecord *record4 = [LostTimeRecord recordWithDate:[[LostTimeRecord dateFormatter] dateFromString:@"2015-04-17T00:00:00-0000"] seconds:@0 reason:@""];
    [[LostTimeDataStore instance] addEntry:record1];
    [[LostTimeDataStore instance] addEntry:record2];
    [[LostTimeDataStore instance] addEntry:record3];
    [[LostTimeDataStore instance] addEntry:record4];

    NSArray *records = [[LostTimeDataStore instance] findAll];
    XCTAssertEqual(records[0], record3);
    XCTAssertEqual(records[1], record1);
    XCTAssertEqual(records[2], record4);
    XCTAssertEqual(records[3], record2);

}

@end