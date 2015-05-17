#import "ReasonController.h"
#import "ReasonDelegate.h"
#import "UIImageViewHelper.h"

@implementation ReasonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIImageViewHelper makeWhite:self.commuteImageView];
    [UIImageViewHelper makeWhite:self.meetingImageView];
    [UIImageViewHelper makeWhite:self.pencilImageView];
}

- (IBAction)commuteButtonTapped:(id)sender {
    [self.delegate setReason:@"commute"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)meetingButtonTapped:(id)sender {
    [self.delegate setReason:@"meeting"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cancel:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

@end