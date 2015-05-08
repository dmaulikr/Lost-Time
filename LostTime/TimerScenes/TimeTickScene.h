#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface TimeTickScene : SKScene

- (void)setText:(NSString *)text;

- (CGFloat)rotationPerSecond;

- (NSString *)outlineImage;
@end