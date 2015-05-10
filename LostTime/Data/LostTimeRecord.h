#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LostTimeRecord : NSObject

@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSNumber *seconds;
@property(nonatomic, strong) NSString *reason;

- (instancetype)initWithDate:(NSDate *)date seconds:(NSNumber *)seconds reason:(NSString *)reason;

+ (instancetype)recordWithDate:(NSDate *)date seconds:(NSNumber *)seconds reason:(NSString *)reason;

- (NSDictionary *)toDictionary;

+ (NSDateFormatter *)dateFormatter;

+ (LostTimeRecord *)fromDictionary:(NSDictionary *)dict;

@end