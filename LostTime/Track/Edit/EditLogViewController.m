#import "EditLogViewController.h"
#import "LostTimeRecord.h"

@implementation EditLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

    [self.reasonTextField setText:self.record.reason];
    [self.endTimeField setText:
            [self.dateTimeFormatter stringFromDate:self.record.date]];

    [self.startTimeField setText:
            [self.dateTimeFormatter stringFromDate:[self.record startDate]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)durationLockChanged:(id)sender {
    [self.endTimeField setEnabled:![self.durationLock isOn]];
}

- (NSDateFormatter *)dateTimeFormatter {
    if (!_dateTimeFormatter) {
        _dateTimeFormatter = [[NSDateFormatter alloc] init];
        [_dateTimeFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return _dateTimeFormatter;
}
@end