//
//  CMatch.m
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CMatch.h"


@implementation Match (CMatch)

- (TeamParticipant*) teamParticipantForClub:(Club*) club
{
    for (TeamParticipant* part in [self.participants allObjects])
    {
        if ([[[[part team] club] name] isEqualToString:[club name]])
        {
            // NSLog(@"Found team participant");
            return part;
        }
    }
    return nil;
}

- (TeamParticipant*) homeTeam
{
    for (TeamParticipant* part in [self.participants allObjects])
    {
        if ([[part home] intValue] == 1)
        {
            return part;
        }
    }
    return nil;
}

- (TeamParticipant*) awayTeam
{
    for (TeamParticipant* part in [self.participants allObjects])
    {
        if ([[part home] intValue] != 1)
        {
            return part;
        }
    }
    return nil;
}

- (void) createMatchParticipantsWithRepository:(SqlLiteRepository*)repo homeTeam:(Team*)homeTeam awayTeam:(Team*)awayTeam
{
    TeamParticipant* homeTeamParticipant = [NSEntityDescription insertNewObjectForEntityForName:@"TeamParticipant" inManagedObjectContext:repo.managedObjectContext];
    homeTeamParticipant.team = homeTeam;
    homeTeamParticipant.home = [NSNumber numberWithInt:1];
    homeTeamParticipant.match = self;
    
    [self addParticipantsObject:homeTeamParticipant];
    
    
    TeamParticipant* awayTeamParticipant = [NSEntityDescription insertNewObjectForEntityForName:@"TeamParticipant" inManagedObjectContext:repo.managedObjectContext];
    awayTeamParticipant.team = awayTeam;
    awayTeamParticipant.home = [NSNumber numberWithInt:0];
    awayTeamParticipant.match = self;
    
    [self addParticipantsObject:awayTeamParticipant];
}

@end
