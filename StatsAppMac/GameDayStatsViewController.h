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
#import "CTeamParticipant.h"
#import "Team.h"
#import "Club.h"
#import "CClub.h"
#import "Round.h"
#import "Season.h"
#import "Division.h"

@class StatsAppMacAppDelegate;
@class StatsCell;

@interface GameDayStatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
    UILabel* roundLabel_;
    UILabel* dateLabel_;
    UILabel* divisionLabel_;
    UILabel* homeTeamLabel_;
    UILabel* awayTeamLabel_;
}

@property (nonatomic, retain) IBOutlet UILabel* roundLabel;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* divisionLabel;
@property (nonatomic, retain) IBOutlet UILabel* homeTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* awayTeamLabel;

@end
