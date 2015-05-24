#import <GameKit/GameKit.h>
#import "Achievements.h"
#import "HourAchievement.h"
#import "FirstAchievement.h"
#import "WorkDayInWeekAchievement.h"
#import "SpecificityAchievement.h"
#import "AccountantAchievement.h"

@implementation Achievements

+ (void)checkForAchievements {
    NSArray *achievements = @[
            [FirstAchievement new],
            [HourAchievement new],
            [WorkDayInWeekAchievement new],
            [SpecificityAchievement new],
            [AccountantAchievement new]
    ];
    for (NSObject <AchievementTest> *achievement in achievements) {
        if ([achievement achieved]) {
            [self achievementComplete:achievement.achievementId];
        }
    }
}

+ (void)achievementComplete:(NSString *)achievementId {
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
        if (error) NSLog(@"error");
        for (GKAchievement *ach in achievements) {
            if ([ach.identifier isEqualToString:achievementId]) {
                return;
            }
        }

        GKAchievement *achievementToSend = [[GKAchievement alloc] initWithIdentifier:achievementId];
        achievementToSend.percentComplete = 100;
        achievementToSend.showsCompletionBanner = YES;
        [GKAchievement reportAchievements:@[achievementToSend] withCompletionHandler:^(NSError *error) {
        }];
    }];
}

@end