//
//  TeamParticipant.h
//  StatsAppMac
//
//  Created by David Mackenzie on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Participant.h"

@class PlayerParticipant, Team;

@interface TeamParticipant : Participant {
@private
}
@property (nonatomic, retain) NSNumber * home;
@property (nonatomic, retain) Team * team;
@property (nonatomic, retain) NSSet* playerParticipants;

@end
