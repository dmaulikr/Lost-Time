#import <SpriteKit/SpriteKit.h>
#import "TimerController.h"
#import "SecondsScene.h"
#import "MinutesScene.h"
#import "HoursScene.h"
#import "UIImage+ImageWithColor.h"
#import "AVHexColor.h"
#import "LostTimeRecord.h"
#import "LostTimeDataStore.h"
#import "ReasonController.h"
#import "ReasonDelegate.h"

@interface TimerController () <ReasonDelegate>
@property(weak, nonatomic) IBOutlet UIButton *startStopButton;
@property(weak, nonatomic) IBOutlet SKView *secondsView;
@property(weak, nonatomic) IBOutlet SKView *minutesView;
@property(weak, nonatomic) IBOutlet SKView *hoursView;

@property(nonatomic, strong) NSString *reason;
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

    [self createAndStartTimer];
    self.running = YES;
}

- (void)createAndStartTimer {
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

- (IBAction)startStopTapped:(id)sender {
    self.running = !self.running;
    [self.timer invalidate];
    if (!self.running) {
        LostTimeRecord *record = [LostTimeRecord recordWithDate:[NSDate date] seconds:@(self.secondsPassed) reason:
                self.reason ? self.reason : @""];
        [[LostTimeDataStore instance] addEntry:record];
        [[LostTimeDataStore instance] save];

        [self.startStopButton setTitle:@"Start :(" forState:UIControlStateNormal];
        [self.startStopButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];

        self.secondsPassed = 0;
        self.reason = nil;
        [self updateTimerLabels];

        [self.tabBarController setSelectedIndex:1];
    }
    else {
        [self createAndStartTimer];
        [self.startStopButton setTitle:@"Done!" forState:UIControlStateNormal];
        [self.startStopButton                                            setBackgroundImage:
                [UIImage imageWithColor:[AVHexColor colorWithHexString:@"87D37C"]] forState:UIControlStateNormal];
    }
}

- (IBAction)reasonButtonTapped:(id)sender {
    ReasonController *controller = [[UIStoryboard storyboardWithName:@"ReasonController" bundle:nil] instantiateInitialViewController];
    [controller setDelegate:self];
    [self.navigationController pushViewController:controller animated:YES];
}

@end