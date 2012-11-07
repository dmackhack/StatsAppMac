//
//  PlayerParticipant.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Participant.h"

@class Player, TeamParticipant;

@interface PlayerParticipant : Participant {
@private
}
@property (nonatomic, retain) TeamParticipant * teamParticipant;
@property (nonatomic, retain) Player * player;

@end
