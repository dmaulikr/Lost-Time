#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Achievements : NSObject
+ (void)checkForAchievements;

+ (void)achievementComplete:(NSString *)achievementId;
@end