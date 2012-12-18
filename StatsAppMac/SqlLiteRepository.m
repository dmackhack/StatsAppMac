//
//  SqlLiteRepository.m
//  StatsAppMac
//
//  Created by David Mackenzie on 7/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SqlLiteRepository.h"


@implementation SqlLiteRepository

@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;





/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void) createEditableCopyOfDatabaseIfNeeded
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSURL* documentdDir = [self applicationDocumentsDirectory];
    NSURL* writableDBPath = [documentdDir URLByAppendingPathComponent:@"StatsAppMac.sqlite"];
    
    BOOL dbexists = [fileManager fileExistsAtPath:[writableDBPath path]];
    if (!dbexists)
    {
        NSLog(@"Writeable DB NOT found at path %@", [writableDBPath path]);
        // get the inital db and copy from the Resources. This is the one pre-popluated with data. read-only in the resources directory
        //NSURL* defaultDBPath = nil;
        NSURL* defaultDBPath = [[NSBundle mainBundle] URLForResource:@"StatsAppMac" withExtension:@"sqlite"];
        
        if ([fileManager fileExistsAtPath:[defaultDBPath path]])
        {
            NSLog(@"FOUND default DB at path %@", [defaultDBPath path]);
            NSError* error;
            // copy the file to the Documents directory so it is writable
            BOOL success = [fileManager copyItemAtURL:defaultDBPath toURL:writableDBPath error:&error];
            
            if (!success)
            {
                NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            }
        }
        else
        {
            NSLog(@"Can't find default DB at path %@", [defaultDBPath path]);
        }
    }
    else
    {
        NSLog(@"Writeable db FOUND at path %@", [writableDBPath path]);
    }
    
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"StatsAppMac" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StatsAppMac.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

- (id)init {
    self = [super init];
    if (self) {
        [self createEditableCopyOfDatabaseIfNeeded];
    }
    return self;
}


@end
