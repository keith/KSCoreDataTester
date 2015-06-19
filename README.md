# KSCoreDataTester

[![Build Status](https://travis-ci.org/keith/KSCoreDataTester.svg?branch=master)](https://travis-ci.org/keith/KSCoreDataTester)

Core Data categories to enable simple in memory store creation for
tests.

## Example with [specta](https://github.com/specta/specta)

```objective-c
__block NSManagedObjectContext *managedObjectContext;

beforeAll(^{
    managedObjectContext = [NSManagedObjectContext contextForNewInMemoryStore];
});

beforeEach(^{
    [managedObjectContext resetContextAndStores];
});
```


## Install with [CocoaPods](http://cocoapods.org)

```ruby
pod "KSCoreDataTester"
```
