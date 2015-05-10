#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LostTimeRecord;

@interface LostTimeDataStore : NSObject

@property(nonatomic, strong) NSMutableArray *data;

+ (id)instance;

- (NSArray *)findAll;

- (void)addEntry:(LostTimeRecord *)record;

- (void)empty;
@end