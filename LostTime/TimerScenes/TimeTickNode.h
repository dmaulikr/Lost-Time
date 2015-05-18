#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface TimeTickNode : SKNode

- (void)setText:(NSString *)text;

- (CGFloat)rotationPerSecond;

- (NSString *)outlineImage;

+ (TimeTickNode *)timeNode;
@end