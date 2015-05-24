#import "AccountantAchievement.h"
#import "LostTimeDataStore.h"

@implementation AccountantAchievement

- (BOOL)achieved {
    return [[[LostTimeDataStore instance] findAll] count] >= 10;
}

- (NSString *)achievementId {
    return @"accountant";
}


@end