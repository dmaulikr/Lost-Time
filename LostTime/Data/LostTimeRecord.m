#import "LostTimeRecord.h"

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
    return @{};
}

+ (LostTimeRecord *)fromDictionary:(NSDictionary *)dict {
    return nil;
};

@end