#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IntroMarker : NSObject
+ (BOOL)hasSeenIntro;

+ (void)markSeen;
@end