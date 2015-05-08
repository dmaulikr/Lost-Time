#import "TimeTickScene.h"

@implementation TimeTickScene

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

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

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [text setFontSize:48];
    [text setName:@"text"];
    [text setText:@"59"];
    [text setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    text.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [text setFontColor:[UIColor blackColor]];
    [self addChild:text];

    SKNode *holder = [SKNode node];
    SKSpriteNode *spinner = [SKSpriteNode spriteNodeWithImageNamed:[self outlineImage]];
    spinner.position = CGPointMake(-spinner.size.width / 2, spinner.size.height / 2);
    [holder addChild:spinner];
    holder.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:holder];
    [holder runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:[self rotationPerSecond] duration:1]]];
}


@end