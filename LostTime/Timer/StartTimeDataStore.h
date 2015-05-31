#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StartTimeDataStore : NSObject

+ (void)saveStartTime:(double)timeIntervalSinceEpoch;

+ (void)clearStoredTime;

+ (BOOL)hasStoredStartTime;

+ (NSTimeInterval)loadStartTime;
@end