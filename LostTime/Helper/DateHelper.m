#import "DateHelper.h"

@implementation DateHelper

+ (NSDate *)truncateSecondsForDate:(NSDate *)fromDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *fromDateComponents = [gregorian components:unitFlags fromDate:fromDate];
    return [gregorian dateFromComponents:fromDateComponents];
}

+ (BOOL)isToday:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];

    components = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [cal dateFromComponents:components];

    return [today isEqualToDate:otherDate];
}

+ (BOOL)isYesterday:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                          fromDate:[[NSDate date] dateByAddingTimeInterval:-(60 * 60 * 24)]];
    NSDate *yesterday = [cal dateFromComponents:components];

    components = [cal components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [cal dateFromComponents:components];

    return [yesterday isEqualToDate:otherDate];
}

+ (NSDateFormatter *)monthDayYearFormatter {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    return formatter;
}

@end