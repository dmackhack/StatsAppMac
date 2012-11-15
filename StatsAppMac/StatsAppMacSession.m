//
//  StatsAppMacSession.m
//  StatsAppMac
//
//  Created by David Mackenzie on 16/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StatsAppMacSession.h"


@implementation StatsAppMacSession

@synthesize selectedClub=selectedClub_, selectedMatch=selectedMatch_;

- (void)dealloc
{
    [selectedClub_ release];
    [selectedMatch_ release];
    
    [super dealloc];
}

@end
