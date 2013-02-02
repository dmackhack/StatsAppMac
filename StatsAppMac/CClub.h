//
//  CClub.h
//  StatsAppMac
//
//  Created by David Mackenzie on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlLiteRepository.h"
#import "Club.h"
#import "Team.h"
#import "TeamParticipant.h"
#import "PlayerClub.h"
#import "Player.h"
#import "CPlayer.h"


@interface Club (CClub)

- (NSMutableArray*) combinedClubFixture;
- (NSMutableArray*) currentPlayers;
- (NSMutableArray*) allPlayers;
- (Player*) addNewPlayerWithRepository:(SqlLiteRepository *)repo;

@end
