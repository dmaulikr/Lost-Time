#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "LostTimeRecord.h"

@interface LostTimeRecordTests : XCTestCase
@end

@implementation LostTimeRecordTests

- (void)testSerializesToDictionary {
    NSString *dateString = @"2015-05-10T03:58:39-0400";
    NSDate *date = [[LostTimeRecord dateFormatter] dateFromString:dateString];
    NSString *reason = @"chat with greg";
    NSDictionary *dict = [[LostTimeRecord recordWithDate:date seconds:@600 reason:reason] toDictionary];

    XCTAssertEqualObjects(dict[@"date"], dateString);
    XCTAssertEqualObjects(dict[@"seconds"], @600);
    XCTAssertEqualObjects(dict[@"reason"], @"chat with greg");
}

- (void)testDeserializesFromDictionary {
    NSString *dateString = @"2015-05-10T03:58:39-0400";
    NSDate *date = [[LostTimeRecord dateFormatter] dateFromString:dateString];
    NSString *reason = @"chat with greg";
    LostTimeRecord *record = [LostTimeRecord fromDictionary:
            [[LostTimeRecord recordWithDate:date seconds:@600 reason:reason] toDictionary]];
    XCTAssertEqualObjects(record.date, date);
    XCTAssertEqualObjects(record.seconds, @600);
    XCTAssertEqualObjects(record.reason, reason);
}

@end