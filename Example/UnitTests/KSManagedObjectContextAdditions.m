#import "NSManagedObjectContext+KSAdditions.h"
#import "NSPersistentStoreCoordinator+KSAdditions.h"
#import "Widget.h"

SpecBegin(ManagedObjectContextAdditions)

describe(@"contextForNewInMemoryStore", ^{
    it(@"should return a context for an empty store", ^{
        NSFetchRequest *request = [[NSFetchRequest alloc]
                                   initWithEntityName:[Widget description]];
        NSManagedObjectContext *context = [NSManagedObjectContext
                                           contextForNewInMemoryStore];
        NSArray *widgets = [context executeFetchRequest:request error:NULL];

        expect(widgets.count).to.equal(0);
    });

    it(@"should be able to have multiple stores that are separate", ^{
        NSError *error = nil;
        NSManagedObjectContext *firstContext = [NSManagedObjectContext
                                                contextForNewInMemoryStore];
        NSManagedObjectContext *secondContext = [NSManagedObjectContext
                                                 contextForNewInMemoryStore];

        NSEntityDescription *description = [NSEntityDescription
                                            entityForName:[Widget description]
                                            inManagedObjectContext:firstContext];
        NSFetchRequest *request = [[NSFetchRequest alloc]
                                   initWithEntityName:[Widget description]];
        Widget *widget = [[Widget alloc] initWithEntity:description
                         insertIntoManagedObjectContext:firstContext];
        widget.name = @"Bob";
        widget.widgetID = @1;
        [firstContext save:&error];

        expect(error).to.beNil();
        NSArray *widgets = [firstContext executeFetchRequest:request
                                                       error:&error];

        expect(error).to.beNil();
        expect(widgets.count).to.equal(1);
        widget = [widgets firstObject];
        expect(widget.name).to.equal(@"Bob");
        expect(widget.widgetID).to.equal(@1);

        widgets = [secondContext executeFetchRequest:request error:&error];
        expect(error).to.beNil();
        expect(widgets.count).to.equal(0);
    });
});

describe(@"contextForCoordinator", ^{
    it(@"should return an empty context on the persistent coordinator", ^{
        NSPersistentStoreCoordinator *storeCore = [NSPersistentStoreCoordinator
                                                   newInMemoryStoreCoordinator];
        NSManagedObjectContext *context = [NSManagedObjectContext
                                           contextForCoordinator:storeCore];

        expect(context.persistentStoreCoordinator).to.equal(storeCore);
    });
});

describe(@"resetContextAndStores", ^{
    it(@"should not have an issue with deleting invalid objects", ^{
        NSManagedObjectContext *context = [NSManagedObjectContext
                                           contextForNewInMemoryStore];
        expect([context hasChanges]).to.beFalsy();
        NSEntityDescription *description = [NSEntityDescription
                                            entityForName:[Widget description]
                                            inManagedObjectContext:context];
        Widget *widget = [[Widget alloc] initWithEntity:description
                         insertIntoManagedObjectContext:context];
        widget.widgetID = @2;

        NSError *error = nil;
        BOOL result = [context save:&error];
        expect(result).to.beFalsy();
        expect(error).notTo.beNil();
        expect([context hasChanges]).to.beTruthy();

        result = [context resetContextAndStores];

        expect(result).to.beTruthy();
        expect([context hasChanges]).to.beFalsy();
    });
});

SpecEnd
