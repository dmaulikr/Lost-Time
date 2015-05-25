#import "ConsistencyAchievement.h"
#import "LostTimeDataStore.h"

@implementation ConsistencyAchievement

- (BOOL)achieved {
    NSArray *records = [[LostTimeDataStore instance] findAll];

    NSSet *uniqueReasons = [NSSet setWithArray:[records valueForKey:@"reason"]];
    for (NSString *reason in uniqueReasons) {
        if ([[records filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"reason == %@", reason]] count] >= 10) {
            return YES;
        }
    }

    return NO;
}

- (NSString *)achievementId {
    return @"consistent";
}

@end