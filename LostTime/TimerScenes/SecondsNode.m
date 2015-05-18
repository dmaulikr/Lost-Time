#import "SecondsNode.h"

@implementation SecondsNode

- (CGFloat)rotationPerSecond {
    return (CGFloat) (4 * M_2_PI);
}

- (NSString *)outlineImage {
    return @"circlequarter-green";
}

@end