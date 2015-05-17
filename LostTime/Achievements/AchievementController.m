#import <GameKit/GameKit.h>
#import "AchievementController.h"
#import "GameKitHelper.h"

@interface AchievementController ()
@property(weak, nonatomic) IBOutlet UIButton *openGameCenterButton;

@end

@implementation AchievementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openGameCenterButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.openGameCenterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadAchievementsView];
}

- (IBAction)gameCenterButtonTapped:(id)sender {
    [self loadAchievementsView];
}

- (void)loadAchievementsView {
    if (self.gameCenterViewController) {
        [self presentViewController:self.gameCenterViewController animated:NO completion:nil];
    }
    else {
        [GameKitHelper authenticateGameCenterInView:self whenAuthenticated:^{
            self.gameCenterViewController = [[GKGameCenterViewController alloc] init];
            if (self.gameCenterViewController != nil) {
                self.gameCenterViewController.gameCenterDelegate = self;
                self.gameCenterViewController.viewState = GKGameCenterViewControllerStateAchievements;
                [self presentViewController:self.gameCenterViewController animated:NO completion:nil];
            }
        }];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}


@end