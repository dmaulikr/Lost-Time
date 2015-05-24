#import "SpecificityAchievement.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@implementation SpecificityAchievement

- (BOOL)achieved {
    return [[[[LostTimeDataStore instance] findAll] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
            ^BOOL(LostTimeRecord *record, NSDictionary *bindings) {
                return ![record.reason isEqualToString:@""] &&
                        ![record.reason isEqualToString:@"commute"] &&
                        ![record.reason isEqualToString:@"reason"];
            }]] count] > 0;
}

- (NSString *)achievementId {
    return @"specific";
}

@end