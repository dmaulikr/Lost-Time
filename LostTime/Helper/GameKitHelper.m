#import <GameKit/GameKit.h>
#import "GameKitHelper.h"
#import "Achievements.h"

@implementation GameKitHelper

+ (void)authenticateGameCenterInView:(UIViewController *)controller whenAuthenticated:(void (^)())authenticated {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        if (viewController != nil) {
            [controller presentViewController:viewController animated:YES completion:nil];
        }
        else if (localPlayer.isAuthenticated) {
            [Achievements checkForAchievements];
            authenticated();
        }
        else {
            NSLog(@"No view or authenticated");
        }
    };
}

@end