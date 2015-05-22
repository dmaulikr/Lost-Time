#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LostTimeRecord;

@interface TrackCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *minutes;
@property(weak, nonatomic) IBOutlet UILabel *hours;
@property(weak, nonatomic) IBOutlet UILabel *reason;
@property(weak, nonatomic) IBOutlet UILabel *seconds;

@property (weak, nonatomic) IBOutlet UILabel *timeStartEnd;
- (void)setRecord:(LostTimeRecord *)record;
@end