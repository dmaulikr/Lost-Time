#import "GetStartedViewController.h"
#import "IntroPageController.h"

@implementation GetStartedViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getStartedButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.getStartedButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (IBAction)getStartedTapped:(id)sender {
    [(IntroPageController *) self.parentViewController dismiss];
}

@end