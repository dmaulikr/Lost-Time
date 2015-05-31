#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "StartTimeDataStore.h"

@interface StartTimeDataStoreTests : XCTestCase
@end

@implementation StartTimeDataStoreTests

- (void)setUp {
    [StartTimeDataStore clearStoredTime];
}

- (void)testDetectsStoredData {
    XCTAssertFalse([StartTimeDataStore hasStoredStartTime]);
    [StartTimeDataStore saveStartTime:[NSDate timeIntervalSinceReferenceDate]];
    XCTAssertTrue([StartTimeDataStore hasStoredStartTime]);
    [StartTimeDataStore clearStoredTime];
    XCTAssertFalse([StartTimeDataStore hasStoredStartTime]);
}

- (void)testRetrievesTime {
    [StartTimeDataStore saveStartTime:[NSDate timeIntervalSinceReferenceDate]];
    NSTimeInterval interval = [StartTimeDataStore loadStartTime];
    XCTAssertTrue(interval > 0);
}

@end