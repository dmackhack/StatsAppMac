//
//  ParticipantStatistics.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Participant, User;

@interface ParticipantStatistics : NSManagedObject {
@private
}
@property (nonatomic, retain) Participant * participant;
@property (nonatomic, retain) User * user;

@end
