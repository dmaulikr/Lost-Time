#import "SpecificityAchievement.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@implementation SpecificityAchievement

- (BOOL)achieved {
    return [[[[LostTimeDataStore instance] findAll] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
            ^BOOL(LostTimeRecord *record, NSDictionary *bindings) {
                return ![record.reason isEqualToString:NO_REASON] &&
                        ![record.reason isEqualToString:@"commute"] &&
                        ![record.reason isEqualToString:@"social"] &&
                        ![record.reason isEqualToString:@"meeting"];
            }]] count] > 0;
}

- (NSString *)achievementId {
    return @"specific";
}

@end