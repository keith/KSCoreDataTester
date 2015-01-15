@import CoreData;

@interface NSPersistentStoreCoordinator (KSAdditions)

+ (NSPersistentStoreCoordinator *)newInMemoryStoreCoordinator;

- (BOOL)addInMemoryStore;
- (BOOL)removePersistentStores;
- (BOOL)resetPersistentStores;

@end
