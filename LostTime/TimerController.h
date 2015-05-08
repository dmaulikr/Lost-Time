#import <UIKit/UIKit.h>

@class SecondsScene;

@interface TimerController : UIViewController


@property(nonatomic, strong) SecondsScene *secondsScene;
@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic) int secondsPassed;
@end
