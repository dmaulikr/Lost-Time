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

- (NSArray *)findAll {
    return @[];
}

- (void)addEntry: (LostTimeRecord *) record {

}

@end