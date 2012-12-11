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
#import "PlayerParticipant.h"
#import "Player.h"
#import "CPlayer.h"
#import "CClub.h"
#import "Club.h"

@class StatsAppMacAppDelegate;

@interface SelectTeamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView* availablePlayersTableView_;
    UITableView* selectedTeamTableView_;
    
    NSMutableArray* checkedAvailablePlayers_;
    NSMutableArray* checkedSelectedPlayers_;
    
}

@property (nonatomic, retain) IBOutlet UITableView* availablePlayersTableView;
@property (nonatomic, retain) IBOutlet UITableView* selectedTeamTableView;
@property (nonatomic, retain) NSMutableArray* checkedAvailablePlayers;
@property (nonatomic, retain) NSMutableArray* checkedSelectedPlayers;

- (IBAction)addPlayersToTeam:(id)sender;
- (IBAction)removePlayersFromTeam:(id)sender;

@end
