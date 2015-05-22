#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DayHelper : NSObject

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

@end