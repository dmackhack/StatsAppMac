//
//  CTeamParticipant.m
//  StatsAppMac
//
//  Created by David Mackenzie on 12/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CTeamParticipant.h"


@implementation TeamParticipant (CTeamParticipant)

- (void) addPlayerToTeamParticipant:(Player*)player withRepository:(SqlLiteRepository *)repo
{
    bool addPlayer = true;
    for (PlayerParticipant* part in [self playerParticipants])
    {
        if ([[player userId] intValue] == [[part.player userId] intValue])
        {
            NSLog(@"Player %@ Exists", [player displayName]);
            addPlayer = false;
            break;
        }
    }
    if (addPlayer)
    {
        PlayerParticipant* part = [NSEntityDescription insertNewObjectForEntityForName:@"PlayerParticipant" inManagedObjectContext:repo.managedObjectContext];
        part.player = player;
        part.teamParticipant = self;
    
        NSLog(@"Adding player %@", [player displayName]);
        [self addPlayerParticipantsObject:part];
    }
}

- (NSMutableArray*) playerParticipantsByLastName
{
    NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"player.lastName" ascending:YES] autorelease];
    NSMutableArray* sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    return (NSMutableArray*)[[[self playerParticipants] allObjects] sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSNumber*) teamGoals
{
    int goals = 0;
    for (PlayerParticipant* participant in [self playerParticipants])
    {
        FootyPlayerStatistics* stats = (FootyPlayerStatistics*) participant.participantStatistics;
        goals = goals + [stats.goals intValue];
    }
    return [[NSNumber alloc] initWithInt:goals];
}

- (NSNumber*) teamBehinds
{
    int behinds = 0;
    for (PlayerParticipant* participant in [self playerParticipants])
    {
        FootyPlayerStatistics* stats = (FootyPlayerStatistics*) participant.participantStatistics;
        behinds = behinds + [stats.behinds intValue];
    }
    return [[NSNumber alloc] initWithInt:behinds];
}

- (NSNumber*) teamScore
{
    return [[NSNumber alloc] initWithInt:([[self teamGoals] intValue] * 6) + [[self teamBehinds] intValue]];
}

@end
