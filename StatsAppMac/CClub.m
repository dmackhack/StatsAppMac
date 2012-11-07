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
    return fixture;
}

@end
