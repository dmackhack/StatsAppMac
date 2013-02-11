//
//  CPlayer.m
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CPlayer.h"


@implementation Player (CPlayer)

- (NSString*) displayName
{
    NSString* displayName = [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
    if (self.number != nil)
    {
        if ([self.number intValue] < 10 && [self.number intValue] >= 0)
        {
            displayName = [NSString stringWithFormat:@"%@.  %@", self.number, displayName];
        }
        else
        {
            displayName = [NSString stringWithFormat:@"%@. %@", self.number, displayName];
        }
    }
    return displayName;
}

- (PlayerClub*) playerClubForClub:(Club*) club
{
    PlayerClub* playerClub = nil;
    
    for (PlayerClub* currentPlayerClub in self.clubs)
    {
        if ([currentPlayerClub.club.name compare:club.name] == 0)
        {
            NSLog(@"Clubs match...");
            return currentPlayerClub;
        }
    }
    
    return playerClub;
}

@end
