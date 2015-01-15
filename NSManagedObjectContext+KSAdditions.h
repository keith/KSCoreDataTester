@import CoreData;

@interface NSManagedObjectContext (KSAdditions)

+ (NSManagedObjectContext *)contextForNewInMemoryStore;
+ (NSManagedObjectContext *)contextForCoordinator:(NSPersistentStoreCoordinator *)coordinator;

- (BOOL)resetContextAndStores;

@end
