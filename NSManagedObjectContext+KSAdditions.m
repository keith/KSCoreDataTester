#import "NSManagedObjectContext+KSAdditions.h"
#import "NSPersistentStoreCoordinator+KSAdditions.h"

@implementation NSManagedObjectContext (KSAdditions)

+ (NSManagedObjectContext *)contextForNewInMemoryStore
{
    NSPersistentStoreCoordinator *coordinator = [NSPersistentStoreCoordinator
                                                 newInMemoryStoreCoordinator];
    return [self contextForCoordinator:coordinator];
}

+ (NSManagedObjectContext *)contextForCoordinator:(NSPersistentStoreCoordinator *)coordinator
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:coordinator];
    return context;
}

- (BOOL)resetContextAndStores
{
    BOOL result = [self.persistentStoreCoordinator resetPersistentStores];
    [self reset];
    return result;
}

@end
