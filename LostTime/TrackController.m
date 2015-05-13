#import "TrackController.h"
#import "TrackCell.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@interface TrackController ()
@end

@implementation TrackController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[LostTimeDataStore instance] findAll] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LostTimeRecord *record = [[LostTimeDataStore instance] findAll][(NSUInteger) indexPath.row];
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TrackCell.class) forIndexPath:indexPath];
    [cell setRecord: record];
    return cell;
}

@end