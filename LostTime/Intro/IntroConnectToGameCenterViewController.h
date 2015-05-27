#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IntroConnectToGameCenterViewController : UIViewController {}
@property (weak, nonatomic) IBOutlet UIButton *connectToGameCenterButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *connectedLabel;

@end