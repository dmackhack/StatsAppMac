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
    STAssertTrue([clubs count] == 1, @"Number of players is NOT == 1");
    
    Club* oldHaileybury = [clubs objectAtIndex:0];
    NSLog(@"Club Name: %@", [oldHaileybury name]);
    STAssertEqualObjects([oldHaileybury name], @"Old Haileybury Amateur Football Club", @"Names not equal?");
    
    NSMutableArray* matches = [oldHaileybury combinedClubFixture];
    NSLog(@"Number of matches %i", [matches count]);
    STAssertTrue([matches count] == 1, @"Number of matches?");
}

- (void) dealloc
{
    [self.repo release];
}

@end
