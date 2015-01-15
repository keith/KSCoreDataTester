#import "NSManagedObjectModel+KSAdditions.h"

SpecBegin(ManagedObjectModelAdditions)

describe(@"defaultManagedObjectModel", ^{
    it(@"should return a managed object model with the available models", ^{
        NSManagedObjectModel *model = [NSManagedObjectModel
                                       defaultManagedObjectModel];
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                                  withExtension:@"momd"];
        NSManagedObjectModel *otherModel = [[NSManagedObjectModel alloc]
                                            initWithContentsOfURL:modelURL];

        expect(model).to.equal(otherModel);
    });

    it(@"should have the correct entites", ^{
        NSManagedObjectModel *model = [NSManagedObjectModel
                                       defaultManagedObjectModel];
        NSArray *entities = [model entities];
        NSEntityDescription *description = [entities firstObject];

        expect(entities.count).to.equal(1);
        expect(description.name).to.equal(@"Widget");
    });
});

SpecEnd
