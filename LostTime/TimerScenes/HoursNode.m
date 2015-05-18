#import "HoursNode.h"

@implementation HoursNode

- (CGFloat)rotationPerSecond {
    return (CGFloat) (M_2_PI) / 4;
}

- (NSString *)outlineImage {
    return @"circlequarter-red";
}

@end