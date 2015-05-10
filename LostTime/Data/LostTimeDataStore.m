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

@end