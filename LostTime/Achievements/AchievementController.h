#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AchievementController : UIViewController <GKGameCenterControllerDelegate>


@property(nonatomic, strong) GKGameCenterViewController *gameCenterViewController;
@end