#import "EditLogViewController.h"
#import "LostTimeRecord.h"
#import "DateHelper.h"
#import "LostTimeDataStore.h"

@implementation EditLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit";

    [self.reasonTextField setDelegate:self];

    UIDatePicker *startDatePicker = [UIDatePicker new];
    [startDatePicker setDate:self.record.startDate];
    [startDatePicker addTarget:self action:@selector(startDateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.startTimeField setInputView:startDatePicker];

    UIDatePicker *endDatePicker = [UIDatePicker new];
    [endDatePicker setDate:self.record.date];
    [endDatePicker addTarget:self action:@selector(endDateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.endTimeField setInputView:endDatePicker];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tap];
}

- (void)endDateChanged:(id)endDateChanged {
    UIDatePicker *picker = (UIDatePicker *) [self.endTimeField inputView];

    NSTimeInterval secondsFromStartDate = [picker.date timeIntervalSinceDate:self.record.startDate];
    if (secondsFromStartDate > 0 && ![self.durationLock isOn]) {
        self.record.seconds = @(secondsFromStartDate);
    }
    self.record.date = picker.date;
    [self updateDatePicker:self.startTimeField withDate:[self.record.date dateByAddingTimeInterval:-[self.record.seconds intValue]]];
    [self updateFieldsForRecordValuesAndSave];

    [self removeSecondsFromRecord];
}

- (void)startDateChanged:(id)startDateChanged {
    UIDatePicker *picker = (UIDatePicker *) [self.startTimeField inputView];
    NSTimeInterval secondsFromEndDate = [picker.date timeIntervalSinceDate:self.record.date];
    if (secondsFromEndDate < 0 && ![self.durationLock isOn]) {
        self.record.seconds = @(-secondsFromEndDate);
    }
    else {
        self.record.date = [picker.date dateByAddingTimeInterval:-[self.record.seconds intValue]];
        [self updateDatePicker:self.endTimeField withDate:self.record.date];
    }
    [self updateFieldsForRecordValuesAndSave];

    [self removeSecondsFromRecord];
}

- (void)removeSecondsFromRecord {
    UIDatePicker *startPicker = (UIDatePicker *) [self.startTimeField inputView];
    UIDatePicker *endPicker = (UIDatePicker *) [self.endTimeField inputView];
    self.record.seconds = @([
            [DateHelper truncateSecondsForDate:[endPicker date]]
            timeIntervalSinceDate:
                    [DateHelper truncateSecondsForDate:[startPicker date]]
    ]);
}

- (void)updateDatePicker:(UITextField *)field withDate:(NSDate *)date {
    UIDatePicker *picker = (UIDatePicker *) [field inputView];
    [picker setDate:date];
}

- (void)endEditing {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self updateFieldsForRecordValuesAndSave];
}

- (void)updateFieldsForRecordValuesAndSave {
    [self.reasonTextField setText:self.record.reason];
    [self.endTimeField setText:
            [self.dateTimeFormatter stringFromDate:self.record.date]];
    [self.startTimeField setText:
            [self.dateTimeFormatter stringFromDate:[self.record startDate]]];
    [[LostTimeDataStore instance] save];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.record.reason = [self.reasonTextField text];
    [self updateFieldsForRecordValuesAndSave];
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