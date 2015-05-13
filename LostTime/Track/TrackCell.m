#import "TrackCell.h"
#import "LostTimeRecord.h"

@implementation TrackCell

- (void)setRecord:(LostTimeRecord *)record {
    [self.reason setText:record.reason];

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [self.date setText:[df stringFromDate:record.date]];

    [self.hours setText:[NSString stringWithFormat:@"%dh", [record.seconds intValue] / 3600]];
    [self.minutes setText:[NSString stringWithFormat:@"%dm", [record.seconds intValue] / 60 % 60]];
    [self.seconds setText:[NSString stringWithFormat:@"%ds", [record.seconds intValue] % 60]];
}

@end