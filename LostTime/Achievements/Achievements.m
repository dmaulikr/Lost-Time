#import <GameKit/GameKit.h>
#import "Achievements.h"
#import "HourAchievement.h"
#import "FirstAchievement.h"

@implementation Achievements

+ (void)checkForAchievements {
    if ([[FirstAchievement new] achieved]) {
        [self achievementComplete:@"firstloss"];
    }

    if ([[HourAchievement new] achieved]) {
        [self achievementComplete:@"hour"];
    }
}

+ (void)achievementComplete:(NSString *)achievementId {
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
        if (error) NSLog(@"error");
        for (GKAchievement *ach in achievements) {
            if ([ach.identifier isEqualToString:achievementId]) {
                NSLog(@"Already submitted");
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