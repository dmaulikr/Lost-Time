#import "UIImageViewHelper.h"

@implementation UIImageViewHelper

+ (void)makeWhite:(UIImageView *)imageView {
    imageView.tintColor = [UIColor whiteColor];
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end