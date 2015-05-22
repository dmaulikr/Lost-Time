#import "TrackCell.h"
#import "LostTimeRecord.h"

@implementation TrackCell

- (void)setRecord:(LostTimeRecord *)record {
    [self.reason setText:record.reason];

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"h:mma"];

    [self.timeStartEnd setText:[NSString stringWithFormat:@"%@ - %@", [timeFormatter stringFromDate:record.date], @""]];

    int hours = [record.seconds intValue] / 3600;
    [self.hours setText:[NSString stringWithFormat:@"%dh", hours]];
    [self.hours setHidden:hours == 0];

    int minutes = [record.seconds intValue] / 60 % 60;
    [self.minutes setHidden:minutes == 0];
    [self.minutes setText:[NSString stringWithFormat:@"%dm", minutes]];

    int seconds = [record.seconds intValue] % 60;
    [self.seconds setText:[NSString stringWithFormat:@"%ds", seconds]];
}

@end