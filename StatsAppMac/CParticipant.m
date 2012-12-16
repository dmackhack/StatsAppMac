//
//  CParticipant.m
//  StatsAppMac
//
//  Created by David Mackenzie on 16/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CParticipant.h"


@implementation Participant (CParticipant)

- (void) createFootyPlayerStatisticsToParticipantWithRepository:(SqlLiteRepository*)repo
{
    if (self.participantStatistics == nil)
    {
        FootyPlayerStatistics* statistics = [NSEntityDescription insertNewObjectForEntityForName:@"FootyPlayerStatistics" inManagedObjectContext:repo.managedObjectContext];
        statistics.participant = self;
        self.participantStatistics = statistics;
    }
}

@end
