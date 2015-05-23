#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LostTimeRecord;

@interface EditLogViewController : UIViewController {
}

@property(nonatomic, strong) LostTimeRecord *record;

@property(weak, nonatomic) IBOutlet UITextField *reasonTextField;
@property(weak, nonatomic) IBOutlet UITextField *startTimeField;
@property(weak, nonatomic) IBOutlet UITextField *endTimeField;
@property(weak, nonatomic) IBOutlet UISwitch *durationLock;

@property(nonatomic, strong) NSDateFormatter *dateTimeFormatter;
@end