#import "IntroConnectToGameCenterViewController.h"
#import "GameKitHelper.h"
#import "IntroPageController.h"

@implementation IntroConnectToGameCenterViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.connectToGameCenterButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.connectToGameCenterButton.titleLabel setTextAlignment:NSTextAlignmentCenter];

    [self.connectedLabel setHidden:YES];
}

- (IBAction)connectToGameCenterButton:(id)sender {
    [(IntroPageController *) self.parentViewController enableDisableNavigation:NO];
    [self.connectToGameCenterButton setHidden:YES];
    [[GameKitHelper instance] authenticateGameCenterInView:self whenAuthenticated:^{
        [(IntroPageController *) self.parentViewController enableDisableNavigation:YES];
        [self.activityIndicator setHidden:YES];
        [self.connectedLabel setHidden:NO];
    }                                   failure:^{
        [(IntroPageController *) self.parentViewController enableDisableNavigation:YES];
        [self.activityIndicator setHidden:YES];
        [self.connectedLabel setHidden:NO];
        [self.connectedLabel setText:@"Error :(. You can always try again later."];
    }];
}

@end