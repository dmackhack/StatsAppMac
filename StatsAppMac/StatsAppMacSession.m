//
//  StatsAppMacSession.m
//  StatsAppMac
//
//  Created by David Mackenzie on 16/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StatsAppMacSession.h"


@implementation StatsAppMacSession

@synthesize selectedClub=selectedClub_, selectedMatch=selectedMatch_, selectedClubForEdit=selectedClubForEdit_;

- (void)dealloc
{
    [selectedClub_ release];
    [selectedMatch_ release];
    [selectedClubForEdit_ release];
    
    [super dealloc];
}

- (TeamParticipant*) selectedTeamParticipant
{
    if ([self selectedMatch] != nil && [self selectedClub] != nil)
    {
        // NSLog(@"Found Team Part");
        return [[self selectedMatch] teamParticipantForClub:[self selectedClub]];
    }
    else
    {
        // NSLog(@"Found Team Part Nil");
        return nil;
    }
}

@end
