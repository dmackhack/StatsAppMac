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
    return [NSString stringWithFormat:@"%@. %@, %@", self.number, self.lastName, self.firstName];
}

@end
