//
//  CPlayer.m
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CPlayer.h"


@implementation Player (CPlayer)

- (NSString*) displayName
{
    NSString* displayName = [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
    if (self.number != nil)
    {
        if ([self.number intValue] < 10 && [self.number intValue] >= 0)
        {
            displayName = [NSString stringWithFormat:@"%@.  %@", self.number, displayName];
        }
        else
        {
            displayName = [NSString stringWithFormat:@"%@. %@", self.number, displayName];
        }
    }
    return displayName;
}

- (PlayerClub*) playerClubForClub:(Club*) club
{
    PlayerClub* playerClub = nil;
    
    for (PlayerClub* currentPlayerClub in self.clubs)
    {
        if ([currentPlayerClub.club.name compare:club.name] == 0)
        {
            NSLog(@"Clubs match...");
            return currentPlayerClub;
        }
    }
    
    return playerClub;
}

- (NSNumber *)nextAvailble:(NSString*)idKey forEntityName:(NSString*)entityName inContext:(NSManagedObjectContext *)context
{    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *moc = context;
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    
    [request setEntity:entity];
    // [request setFetchLimit:1];
    
    NSArray *propertiesArray = [[NSArray alloc] initWithObjects:idKey, nil];
    [request setPropertiesToFetch:propertiesArray];
    [propertiesArray release], propertiesArray = nil;
    
    NSSortDescriptor *indexSort = [[NSSortDescriptor alloc] initWithKey:idKey ascending:YES];
    NSArray *array = [[NSArray alloc] initWithObjects:indexSort, nil];
    [request setSortDescriptors:array];
    [array release], array = nil;
    [indexSort release], indexSort = nil;
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    NSManagedObject *maxIndexedObject = [results lastObject];
    [request release], request = nil;
    if (error) {
        NSLog(@"Error fetching index: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    //NSAssert3(error == nil, @"Error fetching index: %@\n%@", [error localizedDescription], [error userInfo]);
    
    NSInteger myIndex = 1;
    if (maxIndexedObject) {
        myIndex = [[maxIndexedObject valueForKey:idKey] integerValue] + 1;
    }
    
    return [NSNumber numberWithInteger:myIndex];
} 


@end
