#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface TimeScene : SKScene
@property(nonatomic) int secondsPassed;

- (void)setSeconds:(int)passed;
@end