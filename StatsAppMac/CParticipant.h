//
//  CParticipant.h
//  StatsAppMac
//
//  Created by David Mackenzie on 16/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Participant.h"
#import "SqlLiteRepository.h"
#import "FootyPlayerStatistics.h"

@interface Participant (CParticipant)

- (void) createFootyPlayerStatisticsToParticipantWithRepository:(SqlLiteRepository*)repo;

@end
