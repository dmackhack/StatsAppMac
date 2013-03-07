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
#import "SelectTeamViewController.h"
#import "StatChangedListener.h"

@class StatsAppMacAppDelegate;
@class StatsCell;

@interface GameDayStatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, StatChangedListener> 
{
    UILabel* roundLabel_;
    UILabel* dateLabel_;
    UILabel* divisionLabel_;
    UILabel* homeTeamLabel_;
    UILabel* awayTeamLabel_;
    
    UILabel* homeGoals_;
    UILabel* homeBehinds_;
    UILabel* homeTotalScore_;
    UILabel* awayGoals_;
    UILabel* awayBehinds_;
    UILabel* awayTotalScore_;
    
    UITableView* statsTableView_;
}

@property (nonatomic, retain) IBOutlet UILabel* roundLabel;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* divisionLabel;
@property (nonatomic, retain) IBOutlet UILabel* homeTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* awayTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* homeGoals;
@property (nonatomic, retain) IBOutlet UILabel* homeBehinds;
@property (nonatomic, retain) IBOutlet UILabel* homeTotalScore;
@property (nonatomic, retain) IBOutlet UILabel* awayGoals;
@property (nonatomic, retain) IBOutlet UILabel* awayBehinds;
@property (nonatomic, retain) IBOutlet UILabel* awayTotalScore;

@property (nonatomic, retain) IBOutlet UITableView* statsTableView;


- (IBAction)selectTeam:(id)sender;
- (IBAction)dismiss:(id)sender;
- (void) refreshData;

@end
