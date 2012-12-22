//
//  CPlayer.m
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CPlayer.h"


@implementation Player (CPlayer)

- (NSString*) displayName
{
    NSString* displayName = [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
    if (self.number != nil)
    {
        displayName = [NSString stringWithFormat:@"%@. %@", self.number, displayName];
    }
    return displayName;
}

@end
