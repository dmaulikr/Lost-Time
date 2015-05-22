#import "GraphHelper.h"
#import "LostTimeRecord.h"
#import "LostTimeDataStore.h"

@implementation GraphHelper

+ (NSArray *)graphDataByReason {
    NSArray *records = [[LostTimeDataStore instance] findAll];
    NSMutableArray *serieses = [@[] mutableCopy];

    for (LostTimeRecord *record in [[records sortedArrayUsingSelector:@selector(date)] reverseObjectEnumerator]) {
        NSString *name = [record.reason isEqualToString:@""] ? @"no reason" : record.reason;
        NSArray *matchingSeries = [serieses filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",
                                                                                                         name]];
        NSDictionary *series;
        if ([matchingSeries count] == 0) {
            [serieses addObject:@{@"name" : name, @"data" : [@[] mutableCopy]}];
            series = [serieses lastObject];
        }
        else {
            series = matchingSeries[0];
        }

        NSArray *datum = @[@([record.date timeIntervalSince1970] * 1000), record.seconds];
        [series[@"data"] addObject:datum];
    }

    return serieses;
}

@end