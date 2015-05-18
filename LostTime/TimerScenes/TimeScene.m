#import "TimeScene.h"
#import "SecondsNode.h"
#import "MinutesNode.h"
#import "HoursNode.h"

@implementation TimeScene

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}


- (void)didMoveToView:(SKView *)view {
    TimeTickNode *hoursNode = [HoursNode timeNode];
    CGFloat height = [hoursNode calculateAccumulatedFrame].size.height;
    hoursNode.position = CGPointMake(self.size.width / 2, height);
    hoursNode.name = @"hours";
    [self addChild:hoursNode];

    TimeTickNode *minutesNode = [MinutesNode timeNode];
    minutesNode.position = CGPointMake(self.size.width / 2, 2.5 * height);
    minutesNode.name = @"minutes";
    [self addChild:minutesNode];

    TimeTickNode *secondsNode = [SecondsNode timeNode];
    secondsNode.position = CGPointMake(self.size.width / 2, 4 * height);
    secondsNode.name = @"seconds";
    [self addChild:secondsNode];
}

- (void)setSeconds:(int)passed {
    TimeTickNode *hoursNode = (TimeTickNode *) [self childNodeWithName:@"hours"];
    TimeTickNode *minutesNode = (TimeTickNode *) [self childNodeWithName:@"minutes"];
    TimeTickNode *secondsNode = (TimeTickNode *) [self childNodeWithName:@"seconds"];

    [secondsNode setText:[NSString stringWithFormat:@"%ds", passed % 60]];
    [minutesNode setText:[NSString stringWithFormat:@"%dm", passed / 60]];
    [hoursNode setText:[NSString stringWithFormat:@"%dh", passed / (60 * 60)]];
}

@end