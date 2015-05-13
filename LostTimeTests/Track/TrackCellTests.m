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

@end