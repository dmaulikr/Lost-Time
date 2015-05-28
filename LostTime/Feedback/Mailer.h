#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface Mailer : NSObject
@property(nonatomic, weak) UIViewController <MFMailComposeViewControllerDelegate> *sender;

+ (id)mailerWithSender:(UIViewController <MFMailComposeViewControllerDelegate> *)sender;

- (void)presentFeedback;
@end