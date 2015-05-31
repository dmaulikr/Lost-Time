#import <SpriteKit/SpriteKit.h>
#import "TimerController.h"
#import "UIImage+ImageWithColor.h"
#import "TimeScene.h"
#import "AVHexColor.h"
#import "LostTimeRecord.h"
#import "LostTimeDataStore.h"
#import "ReasonController.h"
#import "ReasonDelegate.h"
#import "IntroPageController.h"
#import "IntroMarker.h"
#import "StartTimeDataStore.h"

@interface TimerController () <ReasonDelegate>
@property(weak, nonatomic) IBOutlet UIButton *startStopButton;

@property(weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property(nonatomic, strong) NSString *reason;
@end

@implementation TimerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.timeView setAllowsTransparency:YES];
    self.timeScene = [[TimeScene alloc] initWithSize:self.timeView.frame.size];
    [self.timeView presentScene:self.timeScene];

    self.secondsPassed = 0;
    self.reason = @"";
    [self updateLabels];

    if (![IntroMarker hasSeenIntro]) {
        [self showIntro];
    }
    else {
        [self startRunning];
    }
}

- (void)showIntro {
    IntroPageController *pages = [[UIStoryboard storyboardWithName:@"Intro" bundle:nil] instantiateInitialViewController];
    pages.onDismiss = ^{
        [self startRunning];
    };
    [self presentViewController:pages animated:NO completion:nil];
}

- (void)startRunning {
    [self createAndStartTimer];
    self.running = YES;
}

- (void)updateLabels {
    [self updateTimerLabels];
    [self updateReasonLabel];
}

- (void)updateReasonLabel {
    [self.reasonLabel setText:(NSString *) ([self.reason isEqualToString:@""] ? NO_REASON : self.reason)];
}

- (void)setReason:(NSString *)reason {
    _reason = reason;
    [self updateReasonLabel];
}

- (void)createAndStartTimer {
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
    [StartTimeDataStore saveStartTime:self.startTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(tick:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)updateTimerLabels {
    [self.timeScene setSeconds:self.secondsPassed];
}

- (void)tick:(id)tick {
    NSTimeInterval diff = [NSDate timeIntervalSinceReferenceDate] - self.startTime;
    if (diff - self.secondsPassed > 3) {
        self.secondsPassed = (int) diff;
    }
    else {
        self.secondsPassed++;
    }
    [self updateTimerLabels];
}

- (void)setControlsStateForRunning {
    if (!self.running) {
        [self.startStopButton setTitle:@"Start :(" forState:UIControlStateNormal];
        [self.startStopButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        self.reason = nil;
    }
    else {
        [self.startStopButton setTitle:@"Done!" forState:UIControlStateNormal];
        [self.startStopButton                                            setBackgroundImage:
                [UIImage imageWithColor:[AVHexColor colorWithHexString:@"87D37C"]] forState:UIControlStateNormal];
    }
    [self updateTimerLabels];
}

- (IBAction)reasonButtonTapped:(id)sender {
    ReasonController *controller = [[UIStoryboard storyboardWithName:@"ReasonController" bundle:nil] instantiateInitialViewController];
    [controller setDelegate:self];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [StartTimeDataStore clearStoredTime];
    self.running = NO;
    [self.timer invalidate];
    self.secondsPassed = 0;
    [self setControlsStateForRunning];
}

- (IBAction)startStopTapped:(id)sender {
    self.running = !self.running;
    [self.timer invalidate];
    if (!self.running) {
        [StartTimeDataStore clearStoredTime];
        LostTimeRecord *record = [LostTimeRecord recordWithDate:[NSDate date] seconds:@(self.secondsPassed) reason:
                self.reason ? self.reason : @""];
        [[LostTimeDataStore instance] addEntry:record];
        [[LostTimeDataStore instance] save];
        [self.tabBarController setSelectedIndex:1];
    }
    else {
        [self createAndStartTimer];
    }
    self.secondsPassed = 0;
    [self setControlsStateForRunning];
}

@end