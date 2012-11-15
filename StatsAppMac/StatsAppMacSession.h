//
//  StatsAppMacSession.h
//  StatsAppMac
//
//  Created by David Mackenzie on 16/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Club.h"
#import "Match.h"

@interface StatsAppMacSession : NSObject {
    
    Club* selectedClub_;
    Match* selectedMatch_;
    
}

@property (nonatomic, retain) Club* selectedClub;
@property (nonatomic, retain) Match* selectedMatch;

@end
