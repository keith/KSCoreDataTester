#import "NSManagedObjectModel+KSAdditions.h"

@implementation NSManagedObjectModel (KSAdditions)

+ (NSManagedObjectModel *)defaultManagedObjectModel
{
    return [self mergedModelFromBundles:nil];
}

@end
