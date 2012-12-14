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


@end
