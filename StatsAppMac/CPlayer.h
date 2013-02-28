//
//  CPlayer.h
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Club.h"
#import "PlayerClub.h"

@interface Player (CPlayer)

- (NSString*) displayName;
- (PlayerClub*) playerClubForClub:(Club*) club;
- (NSNumber *)nextAvailble:(NSString *)idKey forEntityName:(NSString *)entityName inContext:(NSManagedObjectContext *)context;


@end
