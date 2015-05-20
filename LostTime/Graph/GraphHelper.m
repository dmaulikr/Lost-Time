#import "GraphHelper.h"
#import "LostTimeRecord.h"
#import "LostTimeDataStore.h"

@implementation GraphHelper

+ (NSArray *)graphDataByReason {
    NSArray *records = [[LostTimeDataStore instance] findAll];
    NSMutableArray *series = [@[] mutableCopy];
    
    for(LostTimeRecord *record in records){
        NSArray *matchingSeries = [series filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", record.reason]];
        if([matchingSeries count] == 0){
            [series addObject:@{@"name": record.reason, @"data": [@[] mutableCopy]}];
        }
    }

    return series;
}

@end