#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ReasonDelegate;

@interface ReasonController : UIViewController {
}
@property (weak, nonatomic) IBOutlet UIImageView *commuteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pencilImageView;
@property (weak, nonatomic) IBOutlet UIImageView *meetingImageView;

@property(nonatomic, weak) NSObject <ReasonDelegate> *delegate;
@end