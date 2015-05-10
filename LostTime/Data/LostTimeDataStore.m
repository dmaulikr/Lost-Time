#import "LostTimeDataStore.h"
#import "LostTimeRecord.h"

@implementation LostTimeDataStore

+ (id)instance {
    static LostTimeDataStore *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [@[] mutableCopy];
    }

    return self;
}

- (NSArray *)findAll {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    return [self.data sortedArrayUsingDescriptors:sortDescriptors];
}

- (void)addEntry:(LostTimeRecord *)record {
    [self.data addObject:record];
}

- (void)empty {
    self.data = [@[] mutableCopy];
}

- (void)save {
    NSError *error;
    NSMutableArray *dicts = [@[] mutableCopy];
    for (LostTimeRecord *record in [self findAll]) {
        [dicts addObject:[record toDictionary]];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicts options:nil error:&error];
    if (!error) {
        NSString *serialized = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:@"data"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)loadFromStore {
    NSString *dataString = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    if (dataString) {
        NSError *error;
        NSArray *dicts = [NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:nil error:&error];
        NSMutableArray *records = [@[] mutableCopy];
        for (NSDictionary *dict in dicts) {
            [records addObject:[LostTimeRecord fromDictionary:dict]];
        }
        self.data = records;
    }
}

@end