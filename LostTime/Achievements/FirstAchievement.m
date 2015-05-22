#import "FirstAchievement.h"
#import "LostTimeDataStore.h"

@implementation FirstAchievement

- (BOOL)achieved {
    return [[[LostTimeDataStore instance] findAll] count] > 0;
}

- (NSString *)achievementId {
    return @"firstloss";
}

@end