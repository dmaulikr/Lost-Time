#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IntroPageController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate> {}

@property(nonatomic, strong) NSArray *pages;

@property(nonatomic, copy) void (^onDismiss)();

- (void)dismiss;

- (void)enableDisableNavigation:(BOOL)enable;
@end