#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GraphController : UIViewController <UIWebViewDelegate> {}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end