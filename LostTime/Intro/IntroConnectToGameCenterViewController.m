#import "IntroConnectToGameCenterViewController.h"
#import "GameKitHelper.h"

@implementation IntroConnectToGameCenterViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.connectToGameCenterButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.connectToGameCenterButton.titleLabel setTextAlignment:NSTextAlignmentCenter];

    [self.connectedLabel setHidden:YES];
}

- (IBAction)connectToGameCenterButton:(id)sender {
    [self.connectToGameCenterButton setHidden:YES];
    [GameKitHelper authenticateGameCenterInView:self whenAuthenticated:^{
        [self.activityIndicator setHidden:YES];
        [self.connectedLabel setHidden:NO];
    }                                   failure:^{
        [self.activityIndicator setHidden:YES];
        [self.connectedLabel setHidden:NO];
        [self.connectedLabel setText:@"Error :(. You can always try again later."];
    }];
}

@end