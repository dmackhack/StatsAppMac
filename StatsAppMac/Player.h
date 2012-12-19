//
//  Player.h
//  StatsAppMac
//
//  Created by David Mackenzie on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@class PlayerClub, PlayerParticipant;

@interface Player : User {
@private
}
@property (nonatomic, retain) NSSet* clubs;
@property (nonatomic, retain) NSSet* playerParticipants;

@end
