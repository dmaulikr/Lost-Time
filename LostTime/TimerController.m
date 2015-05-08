#import <SpriteKit/SpriteKit.h>
#import "TimerController.h"
#import "SecondsScene.h"
#import "MinutesScene.h"
#import "HoursScene.h"

@interface TimerController ()
@property(weak, nonatomic) IBOutlet SKView *secondsView;
@property(weak, nonatomic) IBOutlet SKView *minutesView;
@property(weak, nonatomic) IBOutlet SKView *hoursView;
@end

@implementation TimerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.secondsView setAllowsTransparency:YES];
    self.secondsScene = [[SecondsScene alloc] initWithSize:self.secondsView.frame.size];
    [self.secondsView presentScene:self.secondsScene];

    [self.minutesView setAllowsTransparency:YES];
    self.minutesScene = [[MinutesScene alloc] initWithSize:self.minutesView.frame.size];
    [self.minutesView presentScene:self.minutesScene];

    [self.hoursView setAllowsTransparency:YES];
    self.hoursScene = [[HoursScene alloc] initWithSize:self.hoursView.frame.size];
    [self.hoursView presentScene:self.hoursScene];

    self.secondsPassed = 0;
    [self updateTimerLabels];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(tick:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)updateTimerLabels {
    [self.secondsScene setText:[NSString stringWithFormat:@"%ds", self.secondsPassed % 60]];
    [self.minutesScene setText:[NSString stringWithFormat:@"%dm", self.secondsPassed / 60]];
    [self.hoursScene setText:[NSString stringWithFormat:@"%dh", self.secondsPassed / (60 * 60)]];
}

- (void)tick:(id)tick {
    self.secondsPassed++;
    [self updateTimerLabels];
}

@end