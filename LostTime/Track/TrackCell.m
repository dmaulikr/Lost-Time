#import "TrackCell.h"
#import "LostTimeRecord.h"

@implementation TrackCell

- (void)setRecord:(LostTimeRecord *)record {
    [self.reason setText:[record.reason isEqualToString:@""] ? @"no reason" : record.reason];

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"h:mma"];

    [self.timeStartEnd setText:[NSString stringWithFormat:@"%@ - %@",
                                                          [timeFormatter stringFromDate:[record startDate]],
                                                          [timeFormatter stringFromDate:record.date]]];


    int hours = [record.seconds intValue] / 3600;
    [self.hours setText:hours == 0 ? @"" : [NSString stringWithFormat:@"%dh", hours]];

    int minutes = [record.seconds intValue] / 60 % 60;
    [self.minutes setText:minutes == 0 ? @"" : [NSString stringWithFormat:@"%dm", minutes]];

    int seconds = [record.seconds intValue] % 60;
    [self.seconds setText:seconds == 0 ? @"" : [NSString stringWithFormat:@"%ds", seconds]];
}

@end