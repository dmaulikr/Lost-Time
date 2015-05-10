#import "TrackController.h"
#import "TrackCell.h"

@interface TrackController ()
@end

@implementation TrackController

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TrackCell.class) forIndexPath:indexPath];
    return cell;
}

@end