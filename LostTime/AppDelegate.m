#import "AppDelegate.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "DateHelper.h"
#import "TimeHelper.h"
#import "ScreenshotMode.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[LostTimeDataStore instance] loadFromStore];

    if([ScreenshotMode on]){
        NSString *day1 = @"03-02-2015";
        [self example:@"commute" date:day1 hours:1 minutes:2];
        [self example:@"social" date:day1 hours:0 minutes:30];
        [self example:@"meeting" date:day1 hours:0 minutes:40];
        [self example:@"commute" date:day1 hours:0 minutes:15];
        [self example:@"commute" date:day1 hours:0 minutes:14];
        [self example:@"social" date:day1 hours:0 minutes:45];
        [self example:@"commute" date:day1 hours:0 minutes:46];

        NSString *day2 = @"03-03-2015";
        [self example:@"meeting" date:day2 hours:0 minutes:20];
        [self example:@"social" date:day2 hours:0 minutes:20];
        [self example:@"reddit" date:day2 hours:0 minutes:40];

        NSString *day3 = @"03-05-2015";
        [self example:@"commute" date:day3 hours:0 minutes:20];
        [self example:@"social" date:day3 hours:0 minutes:20];
        [self example:@"meeting" date:day3 hours:0 minutes:30];
        [self example:@"social" date:day3 hours:0 minutes:15];
        [self example:@"social" date:day3 hours:0 minutes:20];
        [self example:@"social" date:day3 hours:0 minutes:30];
        [self example:@"meeting" date:day3 hours:0 minutes:30];
        [self example:@"commute" date:day3 hours:0 minutes:40];

        NSString *day4 = @"03-06-2015";
        [self example:@"reddit" date:day4 hours:1 minutes:0];
        [self example:@"social" date:day4 hours:0 minutes:20];
        [self example:@"commute" date:day4 hours:0 minutes:30];
        [self example:@"meeting" date:day4 hours:0 minutes:15];
        [self example:@"social" date:day4 hours:0 minutes:30];
        [self example:@"meeting" date:day4 hours:0 minutes:30];
        [self example:@"commute" date:day4 hours:0 minutes:40];
    }
    return YES;
}

- (void)example:(NSString *)reason date:(NSString *)date hours:(int)hours minutes:(int)minutes {
    [[LostTimeDataStore instance] addEntry:
            [LostTimeRecord recordWithDate:[[DateHelper monthDayYearFormatter] dateFromString:date]
                                   seconds:@([TimeHelper secondsInHours:hours minutes:minutes]) reason:reason]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end