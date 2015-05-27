#import <GameKit/GameKit.h>
#import "GameKitHelper.h"
#import "Achievements.h"

@implementation GameKitHelper

+ (void)authenticateGameCenterInView:(UIViewController *)controller whenAuthenticated:(void (^)())authenticated
                             failure:(void (^)())failure {
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
            failure();
        }
    };
}

@end