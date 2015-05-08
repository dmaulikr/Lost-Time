#import <SpriteKit/SpriteKit.h>
#import "TimerController.h"
#import "SecondsScene.h"

@interface TimerController ()
@property(weak, nonatomic) IBOutlet SKView *secondsView;
@end

@implementation TimerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.secondsView setAllowsTransparency:YES];
    self.secondsScene = [[SecondsScene alloc] initWithSize:self.secondsView.frame.size];
    [self.secondsView presentScene:self.secondsScene];

    self.secondsPassed = 0;
    [self updateTimerLabels];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(tick:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)updateTimerLabels {
    [self.secondsScene setText:[NSString stringWithFormat:@"%d", self.secondsPassed % 60]];
}

- (void)tick:(id)tick {
    self.secondsPassed++;
    [self updateTimerLabels];
}

@end