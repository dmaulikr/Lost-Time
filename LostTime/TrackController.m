#import <GameKit/GameKit.h>
#import "TrackController.h"
#import "TrackCell.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "Achievements.h"
#import "GameKitHelper.h"

@interface TrackController ()
@end

@implementation TrackController

const int EMPTY_VIEW = 1;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    [GameKitHelper authenticateGameCenterInView:self whenAuthenticated:^{
    }];
}

- (void)registerCellNib:(Class)klass {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(klass) bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:NSStringFromClass(klass)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:TrackCell.class];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
}

- (void)addEmptyView {
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"TrackEmptyView" owner:self options:nil][0];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width,
            self.view.frame.size.height -
                    self.navigationController.navigationBar.frame.size.height -
                    [UIApplication sharedApplication].statusBarFrame.size.height);
    [view setFrame:frame];
    [view setTag:EMPTY_VIEW];
    [self.view addSubview:view];
}

- (void)removeEmptyView {
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [[self.view viewWithTag:EMPTY_VIEW] removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = [[[LostTimeDataStore instance] findAll] count];
    if (count == 0) {
        [self addEmptyView];
    }
    else {
        [self removeEmptyView];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LostTimeRecord *record = [[LostTimeDataStore instance] findAll][(NSUInteger) indexPath.row];
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TrackCell.class) forIndexPath:indexPath];
    [cell setRecord:record];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[LostTimeDataStore instance] removeAtIndex:indexPath.row];
        [[LostTimeDataStore instance] save];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end