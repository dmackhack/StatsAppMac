//
//  Participant.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Match, ParticipantStatistics;

@interface Participant : NSManagedObject {
@private
}
@property (nonatomic, retain) Match * match;
@property (nonatomic, retain) ParticipantStatistics * participantStatistics;

@end
