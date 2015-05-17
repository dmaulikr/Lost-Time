#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GameKitHelper : NSObject

+ (void)authenticateGameCenterInView:(UIViewController *)controller whenAuthenticated:(void (^)())authenticated;

@end