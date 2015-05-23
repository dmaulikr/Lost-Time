#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "TrackController.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@interface TrackControllerTests : XCTestCase
@end

@implementation TrackControllerTests

- (void)setUp {
    [super setUp];
    [[LostTimeDataStore instance] empty];
}

- (void)testHasASectionForEachDay {
    TrackController *controller = [TrackController new];
    XCTAssertEqual([controller numberOfSectionsInTableView:nil], 0);
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM-dd-yyyy HH"];

    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-01-2015 00"] seconds:@10 reason:@""]];

    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-01-2015 03"] seconds:@0 reason:@""]];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-01-2015 21"] seconds:@0 reason:@""]];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-01-2015 22"] seconds:@0 reason:@""]];

    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-02-2015 05"] seconds:@10 reason:@""]];

    XCTAssertEqual([controller numberOfSectionsInTableView:nil], 3);
    XCTAssertEqual([controller tableView:nil numberOfRowsInSection:2], 1);
    XCTAssertEqual([controller tableView:nil numberOfRowsInSection:1], 3);
    XCTAssertEqual([controller tableView:nil numberOfRowsInSection:0], 1);
}

- (void) testSectionTitlesMatchDay {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM-dd-yyyy HH"];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-01-2015 12"] seconds:@10 reason:@""]];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-02-2015 12"] seconds:@10 reason:@""]];
    [[LostTimeDataStore instance] addEntry:[LostTimeRecord recordWithDate:[formatter dateFromString:@"03-03-2015 12"] seconds:@10 reason:@""]];

    TrackController *controller = [TrackController new];
    XCTAssertEqualObjects([controller tableView:nil titleForHeaderInSection:0], @"March 3");
    XCTAssertEqualObjects([controller tableView:nil titleForHeaderInSection:1], @"March 2");
}

@end