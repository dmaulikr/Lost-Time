#import "FeedbackController.h"
#import "Mailer.h"

@implementation FeedbackController {}

- (IBAction)contactMeButtonTapped:(id)sender {
    [[Mailer mailerWithSender:self] presentFeedback];
}

@end