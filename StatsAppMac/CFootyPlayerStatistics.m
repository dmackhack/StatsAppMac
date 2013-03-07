//
//  CFootyPlayerStatistics.m
//  StatsAppMac
//
//  Created by David Mackenzie on 7/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CFootyPlayerStatistics.h"


@implementation FootyPlayerStatistics (CFootyPlayerStatistics)

- (NSNumber*) totalScore
{
    return [NSNumber numberWithInt:[self.goals intValue] * 6 + [self.behinds intValue]];
}

@end
