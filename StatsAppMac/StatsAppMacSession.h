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
#import "CMatch.h"
#import "TeamParticipant.h"

@interface StatsAppMacSession : NSObject {
    
    Club* selectedClub_;
    Match* selectedMatch_;
    
    Club* selectedClubForEdit_;
    
}

@property (nonatomic, retain) Club* selectedClub;
@property (nonatomic, retain) Match* selectedMatch;
@property (nonatomic, retain) Club* selectedClubForEdit;

- (TeamParticipant*) selectedTeamParticipant;

@end
