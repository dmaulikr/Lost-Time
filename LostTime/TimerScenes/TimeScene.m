#import "TimeScene.h"
#import "SecondsNode.h"
#import "MinutesNode.h"
#import "HoursNode.h"
#import "ScreenshotMode.h"

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
    minutesNode.position = CGPointMake(self.size.width / 2, (CGFloat) (2.5 * height));
    minutesNode.name = @"minutes";
    [self addChild:minutesNode];

    TimeTickNode *secondsNode = [SecondsNode timeNode];
    secondsNode.position = CGPointMake(self.size.width / 2, 4 * height);
    secondsNode.name = @"seconds";
    [self addChild:secondsNode];
}

- (void)setSeconds:(int)passed {
    self.secondsPassed = passed;
}

- (void)update:(NSTimeInterval)currentTime {
    if ([ScreenshotMode on]) {
        self.secondsPassed = 3 * 60 + 43;
    }

    TimeTickNode *hoursNode = (TimeTickNode *) [self childNodeWithName:@"hours"];
    TimeTickNode *minutesNode = (TimeTickNode *) [self childNodeWithName:@"minutes"];
    TimeTickNode *secondsNode = (TimeTickNode *) [self childNodeWithName:@"seconds"];

    [secondsNode setText:[NSString stringWithFormat:@"%ds", self.secondsPassed % 60]];
    [minutesNode setText:[NSString stringWithFormat:@"%dm", self.secondsPassed / 60]];
    [hoursNode setText:[NSString stringWithFormat:@"%dh", self.secondsPassed / (60 * 60)]];
}


@end