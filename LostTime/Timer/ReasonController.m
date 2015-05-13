#import "ReasonController.h"
#import "ReasonDelegate.h"

@implementation ReasonController 

- (IBAction)commuteButtonTapped:(id)sender {
    [self.delegate setReason:@"commute"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end