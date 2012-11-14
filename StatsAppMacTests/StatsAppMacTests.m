//
//  StatsAppMacTests.m
//  StatsAppMacTests
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsAppMacTests.h"


@implementation StatsAppMacTests

@synthesize repo=_repo;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    
    self.repo = [[SqlLiteRepository alloc] init];
     
}
     
- (void)tearDown
{
    // Tear-down code here.
       
    [super tearDown];
}

- (Club*) fetchClub: (NSString*) name
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSPredicate* clubsByNamePredicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setPredicate:clubsByNamePredicate];
    
    NSArray* clubs = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing clubs in StatsAppMacTests is: %i", [clubs count]);
    
    Club* club = [clubs objectAtIndex:0];
    return club;
}

- (Team*) fetchTeam: (NSUInteger) theId
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Team" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name = %@", @"Seniors"];
    [request setPredicate:predicate];
    
    NSArray* teams = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing teams in StatsAppMacTests is: %i", [teams count]);
    
    Team* team = [teams objectAtIndex:0];
    return team;
}
     
- (void)testFetchPlayers
{
    //STFail(@"Unit tests are not implemented yet in StatsAppMacTests");    
    
    NSLog(@"Populating Player Data");
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSArray* players = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing players in StatsAppMacTests is: %i", [players count]);
    
    STAssertTrue([players count] > 0, @"Number of players is NOT > 0");
}

- (void)testCombinedFixtureForClub
{
    //STFail(@"Unit tests are not implemented yet in StatsAppMacTests");       
    NSLog(@"Populating Player Data");
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSPredicate* clubsByNamePredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", @"Old Haileybury"];
    [request setPredicate:clubsByNamePredicate];
    
    NSArray* clubs = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing clubs in StatsAppMacTests is: %i", [clubs count]);
    STAssertTrue([clubs count] == 1, @"Number of clubs is NOT == 1 is %i", [clubs count]);
    
    Club* oldHaileybury = [clubs objectAtIndex:0];
    NSLog(@"Club Name: %@", [oldHaileybury name]);
    STAssertEqualObjects([oldHaileybury name], @"Old Haileybury Amateur Football Club", @"Names not equal?");
    
    NSMutableArray* matches = [oldHaileybury combinedClubFixture];
    NSLog(@"Number of matches %i", [matches count]);
    STAssertTrue([matches count] >= 1, @"Number of matches?");
    
    Match* selectedMatch = nil;
    for (Match* match in matches)
    {
        NSString* objectID = [[[match objectID] URIRepresentation] absoluteString];
        NSLog(@"Hash: %@", objectID);
        
        int index = 0;
        for (int i = objectID.length - 1; i>=0; i--)
        {
            if ([objectID characterAtIndex:i] == '/')
            {
                index = i;
                break;
            }
        }
        NSString* endObjectID = [objectID substringFromIndex:index+1];
        NSLog(@"endObjectID: %@", endObjectID);
        if ([endObjectID isEqualToString:@"p1"])
        {
            selectedMatch = match;
            break;
        }
    }
    if (selectedMatch != nil)
    {
        //Match* match = [matches objectAtIndex:0];
        for (TeamParticipant* part in [[selectedMatch participants] allObjects])
        {
            NSLog(@"Part: %@", [[part team] name]);
        }
    
        STAssertTrue([[selectedMatch participants] count] == 2, @"Participants not equal?");
    
        NSMutableArray *parts = [NSMutableArray arrayWithArray:[[selectedMatch participants] allObjects]];
    
        TeamParticipant* p1 = [parts objectAtIndex:0];
        TeamParticipant* p2 = [parts objectAtIndex:1];
    
        NSLog(@"Team 1: %@; from club %@", [[p1 team] name], [[[p1 team] club] name]);
        NSLog(@"Team 2: %@; from club %@", [[p2 team] name], [[[p2 team] club] name]);
    }
}

- (Match*) insertMatch
{
    TeamParticipant* p1 = [NSEntityDescription insertNewObjectForEntityForName:@"TeamParticipant" inManagedObjectContext:self.repo.managedObjectContext];
    
    Club* club = [self fetchClub:@"Old Haileybury Amateur Football Club"];
    for (Team* team in [[club teams] allObjects])
    {
        if ([team.name isEqualToString:@"Seniors"])
        {
            NSLog(@"Found team Seniors");
            p1.team = team;
            break;
        }
    }
    
    TeamParticipant* p2 = [NSEntityDescription insertNewObjectForEntityForName:@"TeamParticipant" inManagedObjectContext:self.repo.managedObjectContext];
    
    club = [self fetchClub:@"Old Trinity Football Club"];
    for (Team* team in [[club teams] allObjects])
    {
        if ([team.name isEqualToString:@"Seniors"])
        {
            NSLog(@"Found team Seniors");
            p2.team = team;
            break;
        }
    }
    
    Match* a = [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:self.repo.managedObjectContext];
    a.date = [[NSDate alloc] init];
    
    p1.match = a;
    p2.match = a;
    [a addParticipantsObject:p1];
    [a addParticipantsObject:p2];
    
    return a;
}

- (void) testGetMatch
{
    Match* newMatch = [self insertMatch];
    [self.repo saveContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Match" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSArray* matches = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing matches in StatsAppMacTests is: %i", [matches count]);
    STAssertTrue([matches count] >= 10, @"Number of matches is NOT == %i", [matches count]);
    
    Match* match = [matches objectAtIndex:0];
    for (TeamParticipant* part in [[match participants] allObjects])
    {
        if ([part isKindOfClass:[TeamParticipant class]])
        {
            NSLog(@"Part: %@", [[part team] name]);
        }
        else
        {
            NSLog(@"Part Type: %@", [part.class description]);
        }
    }
}



- (void) dealloc
{
    [self.repo release];
}

@end
