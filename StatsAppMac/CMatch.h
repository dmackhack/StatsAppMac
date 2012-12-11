//
//  CMatch.h
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"
#import "TeamParticipant.h"
#import "Club.h"
#import "Team.h"


@interface Match (CMatch)

- (TeamParticipant*) teamParticipantForClub:(Club*) club;

@end
