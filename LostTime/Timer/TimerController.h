#import <UIKit/UIKit.h>

@class SecondsScene;
@class MinutesScene;
@class HoursScene;

@interface TimerController : UIViewController


@property(nonatomic, strong) SecondsScene *secondsScene;
@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic) int secondsPassed;
@property(nonatomic, strong) MinutesScene *minutesScene;
@property(nonatomic, strong) HoursScene *hoursScene;
@property(nonatomic) BOOL running;
@end
