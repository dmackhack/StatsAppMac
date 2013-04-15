//
//  FootyStatsTests.m
//  FootyStatsTests
//
//  Created by David Mackenzie on 16/04/13.
//
//

#import "FootyStatsTests.h"

@implementation FootyStatsTests

@synthesize repo=repo_;

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

- (void) testRoundNumberSort
{
    NSMutableArray* oddRounds = [[NSMutableArray alloc] init];
    NSMutableArray* evenRounds = [[NSMutableArray alloc] init];
    NSMutableArray* sortedRounds = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<10; i=i+2)
    {
        Round* r1 = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:self.repo.managedObjectContext];
        r1.number = [NSNumber numberWithInt:i];
        [evenRounds addObject:r1];
    }
    for (int i=1; i<11; i=i+2)
    {
        Round* r1 = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:self.repo.managedObjectContext];
        r1.number = [NSNumber numberWithInt:i];
        [evenRounds addObject:r1];
    }
    
    [sortedRounds addObjectsFromArray:evenRounds];
    [sortedRounds addObjectsFromArray:oddRounds];
    
    NSSortDescriptor* numberSort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray* sortedArray = [sortedRounds sortedArrayUsingDescriptors:[NSArray arrayWithObjects:numberSort, nil]];
    for (Round* round in sortedArray)
    {
        NSLog(@"%@", [round.number stringValue]);
    }
}

@end
