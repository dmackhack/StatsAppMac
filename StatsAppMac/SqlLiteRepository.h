//
//  SqlLiteRepository.h
//  StatsAppMac
//
//  Created by David Mackenzie on 7/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SqlLiteRepository : NSObject {
    
}

@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (void) saveContext;



@end
