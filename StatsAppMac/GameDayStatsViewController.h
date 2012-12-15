//
//  GameDayStatsViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "StatsCell.h"
#import "SqlLiteRepository.h"
#import "Match.h"
#import "StatsAppMacSession.h"
#import "TeamParticipant.h"
#import "Team.h"
#import "Club.h"
#import "CClub.h"

@class StatsAppMacAppDelegate;
@class StatsCell;

@interface GameDayStatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
}

@end
