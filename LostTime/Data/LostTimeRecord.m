#import "LostTimeRecord.h"

const NSString *NO_REASON = @"no reason";

@implementation LostTimeRecord

- (instancetype)initWithDate:(NSDate *)date seconds:(NSNumber *)seconds reason:(NSString *)reason {
    self = [super init];
    if (self) {
        self.date = date;
        self.seconds = seconds;
        self.reason = reason;
    }

    return self;
}

+ (instancetype)recordWithDate:(NSDate *)date seconds:(NSNumber *)seconds reason:(NSString *)reason {
    return [[self alloc] initWithDate:date seconds:seconds reason:reason];
}

- (NSDictionary *)toDictionary {
    NSDateFormatter *formatter = [LostTimeRecord dateFormatter];

    return @{
            @"date" : [formatter stringFromDate:self.date],
            @"seconds" : self.seconds,
            @"reason" : self.reason
    };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    return dateFormatter;
}

- (NSDate *)startDate {
    return [self.date dateByAddingTimeInterval:-[self.seconds intValue]];
}

+ (LostTimeRecord *)fromDictionary:(NSDictionary *)dict {
    return [LostTimeRecord recordWithDate:[self.dateFormatter dateFromString:dict[@"date"]]
                                  seconds:dict[@"seconds"]
                                   reason:dict[@"reason"]];
};

- (NSString *)reason {
    if (!_reason || [_reason isEqualToString:@""]) {
        return (NSString *) NO_REASON;
    }
    return _reason;
}


@end