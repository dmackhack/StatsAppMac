//
//  SelectTeamViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 5/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatsAppMacSession.h"
#import "Match.h"
#import "CMatch.h"
#import "TeamParticipant.h"
#import "CTeamParticipant.h"
#import "PlayerParticipant.h"
#import "Player.h"
#import "CPlayer.h"
#import "CClub.h"
#import "Club.h"
#import "SqlLiteRepository.h"
#import "GameDayStatsViewController.h"
#import "FixtureMatchViewController.h"

@class StatsAppMacAppDelegate;

@interface SelectTeamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView* availablePlayersTableView_;
    UITableView* selectedTeamTableView_;
    
    NSMutableArray* availablePlayers_;
    NSMutableArray* selectedPlayers_;
    
    NSMutableArray* checkedAvailablePlayers_;
    NSMutableArray* checkedSelectedPlayers_;
    
    UIView* matchView_;
    
}

@property (nonatomic, retain) IBOutlet UITableView* availablePlayersTableView;
@property (nonatomic, retain) IBOutlet UITableView* selectedTeamTableView;
@property (nonatomic, retain) NSMutableArray* checkedAvailablePlayers;
@property (nonatomic, retain) NSMutableArray* checkedSelectedPlayers;
@property (nonatomic, retain) NSMutableArray* availablePlayers;
@property (nonatomic, retain) NSMutableArray* selectedPlayers;

@property (nonatomic, retain) IBOutlet UIView* matchView;

- (IBAction)addPlayersToTeam:(id)sender;
- (IBAction)removePlayersFromTeam:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
