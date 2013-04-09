//
//  ClubSqlLiteRepository.m
//  StatsAppMac
//
//  Created by David Mackenzie on 17/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ClubSqlLiteRepository.h"


@implementation ClubSqlLiteRepository

@synthesize repo=repo_;

- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.repo = [[self appDelegate] repo];
    }
    
    return self;
}

-(void)dealloc
{
    [cache_ release];
    [resultsController_ release];
    [repo_ release];
    
    [super dealloc];
}

-(NSArray*) fetchClubs: (NSString*)searchTerm
{
    NSLog(@"Fetching Clubs");
    StatsAppMacAppDelegate* appDel = self.appDelegate;
    SqlLiteRepository* repo = [appDel repo];
    
    NSManagedObjectContext* context = [repo managedObjectContext];
    NSFetchRequest* fetchClubsByName = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* playerEntityDescription = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:context];
    [fetchClubsByName setEntity:playerEntityDescription];
    
    //NSString* searchTerm = nil;
    NSLog(@"Search Term: [%@]", searchTerm);
    if (searchTerm != nil && [searchTerm length] > 0)
    {    
        NSLog(@"Appending Predicate");
        NSPredicate* clubsByNamePredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchTerm];
        [fetchClubsByName setPredicate:clubsByNamePredicate];
    }
    
    NSSortDescriptor* clubsByNameSD = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchClubsByName setSortDescriptors:[NSArray arrayWithObject:clubsByNameSD]];
    
    resultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchClubsByName managedObjectContext:context sectionNameKeyPath:nil cacheName:cache_];
    
    //resultsController_.delegate = self;
    
    NSError* error;
    BOOL success = [resultsController_ performFetch:&error];
    
    if (!success)
    {
        NSLog(@"Error fetching results");
    }
    [fetchClubsByName release];
    return [resultsController_ fetchedObjects];
}



@end
