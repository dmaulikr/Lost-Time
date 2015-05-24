#import "ReasonController.h"
#import "ReasonDelegate.h"
#import "UIImageViewHelper.h"
#import "PaddedTextField.h"

@implementation ReasonController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIImageViewHelper makeWhite:self.commuteImageView];
    [UIImageViewHelper makeWhite:self.meetingImageView];
    [UIImageViewHelper makeWhite:self.socialImageView];

    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self.view addGestureRecognizer:tap];

    [self.reasonTextField setDelegate:self];
}

- (void)viewTapped {
    [self.reasonTextField endEditing:YES];
}

- (IBAction)commuteButtonTapped:(id)sender {
    [self.delegate setReason:@"commute"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)meetingButtonTapped:(id)sender {
    [self.delegate setReason:@"meeting"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)socialButtonTapped:(id)sender {
    [self.delegate setReason:@"social"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate setReason:[self.reasonTextField text]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end