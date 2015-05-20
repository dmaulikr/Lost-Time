#import "GraphController.h"

@implementation GraphController {}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"web/graph" ofType:@"html"]isDirectory:NO]]];
}

@end