#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DateHelper : NSObject

+ (NSDate *)truncateSecondsForDate:(NSDate *)fromDate;

+ (BOOL)isToday:(NSDate *)date;

+ (BOOL)isYesterday:(NSDate *)date;

+ (NSDateFormatter *)monthDayYearFormatter;

@end