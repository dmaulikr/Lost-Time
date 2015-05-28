#import <GameKit/GameKit.h>
#import "GraphController.h"
#import "GraphHelper.h"
#import "Achievements.h"

@implementation GraphController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"web/graph" ofType:@"html"] isDirectory:NO]]];

    if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
        [Achievements achievementComplete:@"analyst"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.webView.isLoading) {
        [self buildGraph:self.webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self buildGraph:webView];
}

- (void)buildGraph:(UIWebView *)webView {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[GraphHelper graphDataByReason] options:nil error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [webView stringByEvaluatingJavaScriptFromString:
            [NSString stringWithFormat:@"window.buildTimeGraph(%@);", json]];
}


@end