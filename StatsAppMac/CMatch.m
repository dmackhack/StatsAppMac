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
            NSLog(@"Found team participant");
            return part;
        }
    }
    return nil;
}

@end
