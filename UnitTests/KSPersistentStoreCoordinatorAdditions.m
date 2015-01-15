#import "NSPersistentStoreCoordinator+KSAdditions.h"
#import "Widget.h"

SpecBegin(PersistentStoreCoordinatorAdditions)

describe(@"newInMemoryStoreCoordinator", ^{
    it(@"should return a new persistent store coordinator", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        NSArray *stores = [storeCore persistentStores];
        NSPersistentStore *store = [stores firstObject];

        expect(storeCore).notTo.beNil();
        expect(stores.count).to.equal(1);
        expect(store.type).to.equal(NSInMemoryStoreType);
        expect(store.persistentStoreCoordinator).to.equal(storeCore);
    });

    it(@"should have the managed object model", ^{
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                                  withExtension:@"momd"];
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc]
                                       initWithContentsOfURL:modelURL];
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        expect(storeCore.managedObjectModel).to.equal(model);
    });
});

describe(@"removePersistentStores", ^{
    it(@"should remove all stores", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        NSArray *stores = [storeCore persistentStores];

        expect(stores.count).to.equal(1);
        BOOL result = [storeCore removePersistentStores];
        expect(result).to.beTruthy();

        stores = [storeCore persistentStores];
        expect(stores.count).to.equal(0);
    });

    it(@"should remove stores if the coordinator has more than one", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        [storeCore addPersistentStoreWithType:NSInMemoryStoreType
                                configuration:nil
                                          URL:nil
                                      options:nil
                                        error:NULL];
        NSArray *stores = [storeCore persistentStores];

        expect(stores.count).to.equal(2);
        BOOL result = [storeCore removePersistentStores];
        expect(result).to.beTruthy();

        stores = [storeCore persistentStores];
        expect(stores.count).to.equal(0);
    });
});

describe(@"addInMemoryStore", ^{
    it(@"should add a store", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        NSArray *stores = [storeCore persistentStores];

        expect(stores.count).to.equal(1);
        BOOL result = [storeCore addInMemoryStore];
        expect(result).to.beTruthy();

        stores = [storeCore persistentStores];
        expect(stores.count).to.equal(2);
    });
});

describe(@"resetPersistentStores", ^{
    it(@"should reset the stores", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        NSArray *stores = [storeCore persistentStores];

        expect(stores.count).to.equal(1);
        BOOL result = [storeCore resetPersistentStores];
        expect(result).to.beTruthy();

        stores = [storeCore persistentStores];
        expect(stores.count).to.equal(1);
    });

    it(@"should remove any data created previously", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:storeCore];
        NSEntityDescription *description = [NSEntityDescription
                                            entityForName:[Widget description]
                                            inManagedObjectContext:context];

        Widget *widget = [[Widget alloc] initWithEntity:description
                         insertIntoManagedObjectContext:context];
        widget.name = @"Bob";
        widget.widgetID = @1;
        [context save:nil];

        NSError *error = nil;
        NSFetchRequest *request = [[NSFetchRequest alloc]
                                   initWithEntityName:[Widget description]];
        NSArray *widgets = [context executeFetchRequest:request error:&error];

        expect(error).to.beNil();
        expect(widgets.count).to.equal(1);
        Widget *fetchedWidget = [widgets firstObject];
        expect(fetchedWidget.name).to.equal(@"Bob");
        expect(fetchedWidget.widgetID).to.equal(@1);

        [storeCore resetPersistentStores];
        widgets = [context executeFetchRequest:request error:&error];

        expect(error).to.beNil();
        expect(widgets.count).to.equal(0);
    });
});

SpecEnd
