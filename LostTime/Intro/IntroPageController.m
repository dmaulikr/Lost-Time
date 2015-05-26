#import "IntroPageController.h"

@implementation IntroPageController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.delegate = self;

    UIViewController *p1 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1"];
    UIViewController *p2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page2"];
    UIViewController *p3 = [self.storyboard instantiateViewControllerWithIdentifier:@"page3"];
    self.pages = @[p1, p2, p3];
    [self setViewControllers:@[p1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    if (currentIndex > 0) {
        return self.pages[currentIndex - 1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    if (currentIndex < [self.pages count] - 1) {
        return self.pages[currentIndex + 1];
    }
    return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pages count];
}

- (NSInteger)presentationIndexForPageViewController:
        (UIPageViewController *)pageViewController {
    return 0;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:self.onDismiss];
}

@end