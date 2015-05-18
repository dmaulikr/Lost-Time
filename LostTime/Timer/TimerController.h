#import <UIKit/UIKit.h>

@class TimeScene;

@interface TimerController : UIViewController

@property(weak, nonatomic) IBOutlet SKView *timeView;

@property(nonatomic, strong) TimeScene *timeScene;
@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic) int secondsPassed;
@property(nonatomic) BOOL running;
@property(nonatomic) NSTimeInterval startTime;
@end
