#import "GraphController.h"
#import "GraphHelper.h"

@implementation GraphController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"web/graph" ofType:@"html"] isDirectory:NO]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[GraphHelper graphDataByReason] options:nil error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [webView stringByEvaluatingJavaScriptFromString:
            [NSString stringWithFormat:@"window.buildGraph(%@);", json]];
}


@end