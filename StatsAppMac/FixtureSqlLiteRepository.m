//
//  FixtureSqlLiteRepository.m
//  StatsAppMac
//
//  Created by David Mackenzie on 9/04/13.
//
//

#import "FixtureSqlLiteRepository.h"

@implementation FixtureSqlLiteRepository

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

- (NSArray*) fetchLeaguesByName:(NSString*)name
{
    
    NSLog(@"Fetching Leagues");
    StatsAppMacAppDelegate* appDel = self.appDelegate;
    SqlLiteRepository* repo = [appDel repo];
    
    NSManagedObjectContext* context = [repo managedObjectContext];
    NSFetchRequest* fetchLeaguesByName = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* leagueEntityDescription = [NSEntityDescription entityForName:@"League" inManagedObjectContext:context];
    [fetchLeaguesByName setEntity:leagueEntityDescription];
    
    //NSString* searchTerm = nil;
    NSLog(@"League Search Term: [%@]", name);
    if (name != nil && [name length] > 0)
    {
        NSLog(@"Appending Predicate");
        NSPredicate* leaguesByNamePredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", name];
        [fetchLeaguesByName setPredicate:leaguesByNamePredicate];
    }
    
    NSSortDescriptor* leaguesByNameSD = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchLeaguesByName setSortDescriptors:[NSArray arrayWithObject:leaguesByNameSD]];
    
    resultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchLeaguesByName managedObjectContext:context sectionNameKeyPath:nil cacheName:cache_];
    
    //resultsController_.delegate = self;
    
    NSError* error;
    BOOL success = [resultsController_ performFetch:&error];
    
    if (!success)
    {
        NSLog(@"Error fetching results");
    }
    [fetchLeaguesByName release];
    return [resultsController_ fetchedObjects];
}

@end
