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
    return players;
}

@end
