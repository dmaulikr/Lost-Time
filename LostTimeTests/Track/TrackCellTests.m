#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TrackCell.h"
#import "LostTimeRecord.h"

@interface TrackCellTests : XCTestCase
@end

@implementation TrackCellTests

- (void)testSetsTimeLabels {
    TrackCell *cell = [[NSBundle mainBundle] loadNibNamed:@"TrackCell" owner:self options:nil][0];
    [cell setRecord:[LostTimeRecord recordWithDate:[NSDate date] seconds:@3750 reason:@"test"]];
    XCTAssertEqualObjects([cell.hours text], @"1h");
    XCTAssertEqualObjects([cell.minutes text], @"2m");
    XCTAssertEqualObjects([cell.seconds text], @"30s");
}

- (void)testHides0Values {
    TrackCell *cell = [[NSBundle mainBundle] loadNibNamed:@"TrackCell" owner:self options:nil][0];
    [cell setRecord:[LostTimeRecord recordWithDate:[NSDate date] seconds:@3500 reason:@"test"]];
    XCTAssertTrue([cell.hours isHidden]);
    XCTAssertFalse([cell.minutes isHidden]);
    XCTAssertFalse([cell.seconds isHidden]);

    [cell setRecord:[LostTimeRecord recordWithDate:[NSDate date] seconds:@59 reason:@"test"]];
    XCTAssertTrue([cell.minutes isHidden]);
}

- (void)testSetsTimeStartEnd {
    TrackCell *cell = [[NSBundle mainBundle] loadNibNamed:@"TrackCell" owner:self options:nil][0];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"h:mm:ssa"];
    [cell setRecord:[LostTimeRecord recordWithDate:[formatter dateFromString:@"10:01:32PM"] seconds:@(51 * 60) reason:@"test"]];
    XCTAssertEqualObjects([cell.timeStartEnd text], @"9:10PM - 10:01PM");
}

- (void)testHandlesEmptyReason {
    TrackCell *cell = [[NSBundle mainBundle] loadNibNamed:@"TrackCell" owner:self options:nil][0];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"h:mm:ssa"];
    [cell setRecord:[LostTimeRecord recordWithDate:[formatter dateFromString:@"10:01:32PM"] seconds:@(51 * 60) reason:@""]];
    XCTAssertEqualObjects([cell.reason text], @"no reason");
}

@end