//
//  TeamParticipant.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Participant.h"

@class PlayerParticipant, Team;

@interface TeamParticipant : Participant {
@private
}
@property (nonatomic, retain) Team * team;
@property (nonatomic, retain) NSSet* playerParticipants;

@end
