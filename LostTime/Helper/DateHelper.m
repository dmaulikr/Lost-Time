#import "DateHelper.h"

@implementation DateHelper

+ (NSDate *)truncateSecondsForDate:(NSDate *)fromDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *fromDateComponents = [gregorian components:unitFlags fromDate:fromDate];
    return [gregorian dateFromComponents:fromDateComponents];
}

@end