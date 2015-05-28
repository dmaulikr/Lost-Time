#import "IntroMarker.h"

@implementation IntroMarker

+ (BOOL) hasSeenIntro {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"intro"];
}

+ (void)markSeen {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"intro"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end