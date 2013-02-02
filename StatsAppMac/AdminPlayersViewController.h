//
//  AdminPlayersViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 15/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListClubsTableViewConroller.h"
#import "ListPlayersViewController.h"
#import "SqlLiteRepository.h"
#import "StatsAppMacSession.h"
#import "Club.h"
#import "CClub.h"
#import "Player.h"
#import "CPlayer.h"
#import "EditPlayerViewController.h"

@class StatsAppMacAppDelegate;


@interface AdminPlayersViewController : UIViewController {
    
    ListClubsTableViewConroller* leftViewController_;
    UITableView* leftTableView_;
    ListPlayersViewController* rightViewContoller_;
    UITableView* rightTableView_;
}

@property (nonatomic, retain) ListClubsTableViewConroller* leftViewController;
@property (nonatomic, retain) IBOutlet UITableView* leftTableView;
@property (nonatomic, retain) ListPlayersViewController* rightViewController;
@property (nonatomic, retain) IBOutlet UITableView* rightTableView;

- (IBAction)addPlayer:(id)sender;

@end
