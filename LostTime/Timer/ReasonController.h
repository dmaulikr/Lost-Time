#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ReasonDelegate;
@class PaddedTextField;

@interface ReasonController : UIViewController <UITextFieldDelegate> {
}
@property (weak, nonatomic) IBOutlet UIImageView *commuteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pencilImageView;
@property (weak, nonatomic) IBOutlet UIImageView *meetingImageView;
@property (weak, nonatomic) IBOutlet PaddedTextField *reasonTextField;

@property(nonatomic, weak) NSObject <ReasonDelegate> *delegate;
@end