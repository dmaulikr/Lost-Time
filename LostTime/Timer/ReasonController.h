#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ReasonDelegate;

@interface ReasonController : UIViewController {
}

@property(nonatomic, weak) NSObject <ReasonDelegate> *delegate;
@end