#import <GameKit/GameKit.h>
#import "TrackController.h"
#import "TrackCell.h"
#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"
#import "EditLogViewController.h"
#import "DateHelper.h"

@interface TrackController ()
@end

@implementation TrackController

const int EMPTY_VIEW = 1;

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self checkAddEmptyView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        NSArray *recordsInSection = [self recordsGroupedByDay][(NSUInteger) indexPath.section];
        BOOL removeSection = [recordsInSection count] == 1;
        [[LostTimeDataStore instance] remove:recordsInSection[(NSUInteger) indexPath.row]];
        [[LostTimeDataStore instance] save];
        if (removeSection) {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:(NSUInteger) indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [self.tableView endUpdates];
        [self checkAddEmptyView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self recordsGroupedByDay] count];
}

- (NSArray *)recordsGroupedByDay {
    NSArray *records = [[LostTimeDataStore instance] findAll];
    NSString *previousDay = nil;
    NSMutableArray *groups = [@[] mutableCopy];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    for (LostTimeRecord *record in records) {
        NSString *dateString = [formatter stringFromDate:[record.date
                dateByAddingTimeInterval:-[record.seconds intValue]]];
        if (!previousDay || ![previousDay isEqualToString:dateString]) {
            previousDay = dateString;
            [groups addObject:[@[] mutableCopy]];
        }

        [[groups lastObject] addObject:record];
    }
    return groups;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDate *date = [self.recordsGroupedByDay[(NSUInteger) section][0] date];
    if ([DateHelper isToday:date]) {
        return @"Today";
    }
    else if ([DateHelper isYesterday:date]) {
        return @"Yesterday";
    }
    return [self.sectionTitleDateFormatter stringFromDate:date];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self checkAddEmptyView];
    return [[self recordsGroupedByDay][(NSUInteger) section] count];
}

- (void)checkAddEmptyView {
    int count = [[[LostTimeDataStore instance] findAll] count];
    if (count == 0 && ![self.view viewWithTag:EMPTY_VIEW]) {
        [self addEmptyView];
    }
    else {
        [self removeEmptyView];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LostTimeRecord *record = [self recordsGroupedByDay][(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TrackCell.class) forIndexPath:indexPath];
    [cell setRecord:record];
    return cell;
}

- (NSDateFormatter *)sectionTitleDateFormatter {
    if (!_sectionTitleDateFormatter) {
        _sectionTitleDateFormatter = [NSDateFormatter new];
        [_sectionTitleDateFormatter setDateFormat:@"MMMM d"];
    }
    return _sectionTitleDateFormatter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditLogViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([EditLogViewController class]) bundle:nil] instantiateInitialViewController];
    controller.record = [self recordsGroupedByDay][(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end