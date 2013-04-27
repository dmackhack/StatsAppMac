//
//  CClub.m
//  StatsAppMac
//
//  Created by David Mackenzie on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CClub.h"


@implementation Club (CClub)

- (NSMutableArray*) combinedClubFixture
{
    NSMutableArray* fixture = [[NSMutableArray alloc] init];
    for (Team *team in [[self teams] allObjects])
    {
        for (TeamParticipant *participant in [team teamParticipants])
        {
            [fixture addObject:[participant match]];
        }
    }
    NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
    NSMutableArray* sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    return (NSMutableArray*)[fixture sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSMutableArray*) currentPlayers
{
    NSMutableArray* players = [[NSMutableArray alloc] init];
    for (PlayerClub* playerClub in [[self players] allObjects])
    {
        if ([[playerClub active] intValue] == 1)
        {
            [players addObject:[playerClub player]];
        }
    }
    NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES] autorelease];
    NSMutableArray* sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    return (NSMutableArray*)[players sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSMutableArray*) allPlayers
{
    NSMutableArray* players = [[NSMutableArray alloc] init];
    for (PlayerClub* playerClub in [[self players] allObjects])
    {
        [players addObject:[playerClub player]];
    }
    NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES] autorelease];
    NSMutableArray* sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    return (NSMutableArray*)[players sortedArrayUsingDescriptors:sortDescriptors];
}

- (Player*) addNewPlayerWithRepository:(SqlLiteRepository *)repo
{
    Player* playerEntity = nil;
    
    PlayerClub* playerClub = [NSEntityDescription insertNewObjectForEntityForName:@"PlayerClub" inManagedObjectContext:repo.managedObjectContext];
    playerEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:repo.managedObjectContext];
        
    playerEntity.firstName = @"";
    playerEntity.lastName = @"";
    playerEntity.number = 0;
        
    playerClub.club = self;
    playerClub.player = playerEntity;
    playerClub.active = [NSNumber numberWithInt:1];
        
    [playerEntity addClubsObject:playerClub];
        
    NSLog(@"Adding player %@", [playerEntity displayName]);
    [self addPlayersObject:playerClub];
    
    return playerEntity;
}

- (Team*) addNewTeam:(NSString*)name withRepository:(SqlLiteRepository*) repo
{
    Team* newTeam = nil;
    bool exists = false;
    for (Team* team in self.teams)
    {
        if ([team.name isEqualToString:name])
        {
            exists = true;
            break;
        }
    }
    if (!exists)
    {
        newTeam = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:repo.managedObjectContext];
        newTeam.name = name;
        newTeam.club = self;
        [self addTeamsObject:newTeam];
        NSLog(@"Adding Team: %@. Number of teams %d", newTeam.name, [self.teams count]);
    }
    return newTeam;
}

@end
