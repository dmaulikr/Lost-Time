#import "FeedbackController.h"
#import "Mailer.h"

@implementation FeedbackController {
}

- (IBAction)contactMeButtonTapped:(id)sender {
    [[Mailer mailerWithSender:self] presentFeedback];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}

@end