#import "NSManagedObjectModel+KSAdditions.h"
#import "NSPersistentStoreCoordinator+KSAdditions.h"

@implementation NSPersistentStoreCoordinator (KSAdditions)

+ (NSPersistentStoreCoordinator *)newInMemoryStoreCoordinator
{
    NSManagedObjectModel *model = [NSManagedObjectModel defaultManagedObjectModel];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]
                                                 initWithManagedObjectModel:model];
    [coordinator addInMemoryStore];
    return coordinator;
}

- (BOOL)addInMemoryStore
{
    return !![self addPersistentStoreWithType:NSInMemoryStoreType
                                configuration:nil
                                          URL:nil
                                      options:nil
                                        error:nil];
}

- (BOOL)removePersistentStores
{
    NSError *error = nil;
    NSArray *stores = [[self persistentStores] copy];
    for (NSPersistentStore *store in stores) {
        [self removePersistentStore:store error:&error];
        if (error) {
            return NO;
        }
    }

    return YES;
}

- (BOOL)resetPersistentStores
{
    BOOL status = [self removePersistentStores];
    if (!status) {
        return status;
    }

    return [self addInMemoryStore];
}

@end
