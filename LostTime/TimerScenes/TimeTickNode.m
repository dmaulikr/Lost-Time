#import "TimeTickNode.h"

@implementation TimeTickNode

- (void)setText:(NSString *)text {
    SKLabelNode *label = (SKLabelNode *) [self childNodeWithName:@"text"];
    [label setText:text];
}

- (CGFloat)rotationPerSecond {
    return 0;
}

- (NSString *)outlineImage {
    return nil;
}

+ (TimeTickNode *)timeNode {
    TimeTickNode *node = [self node];
    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [text setFontSize:48];
    [text setName:@"text"];
    [text setText:@"59"];
    [text setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    [text setFontColor:[UIColor blackColor]];
    [node addChild:text];

    SKNode *holder = [SKNode node];
    SKSpriteNode *spinner = [SKSpriteNode spriteNodeWithImageNamed:[node outlineImage]];
    spinner.position = CGPointMake(-spinner.size.width / 2, spinner.size.height / 2);
    [holder addChild:spinner];
    [node addChild:holder];
    [holder runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:[node rotationPerSecond] duration:1]]];

    [holder setScale:0.8];
    return node;
}


@end