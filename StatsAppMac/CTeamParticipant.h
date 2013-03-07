//
//  CTeamParticipant.h
//  StatsAppMac
//
//  Created by David Mackenzie on 12/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeamParticipant.h"
#import "Player.h"
#import "CPlayer.h"
#import "PlayerParticipant.h"
#import "FootyPlayerStatistics.h"
#import "SqlLiteRepository.h"

@interface TeamParticipant (CTeamParticipant)

- (void) addPlayerToTeamParticipant:(Player*)player withRepository:(SqlLiteRepository*)repo;
- (NSMutableArray*) playerParticipantsByLastName;

- (NSNumber*) teamGoals;
- (NSNumber*) teamBehinds;
- (NSNumber*) teamScore;

@end
