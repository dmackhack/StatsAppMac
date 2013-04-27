//
//  FixtureSearchDelegate.h
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "CClub.h"
#import "MultiColumnTableCell.h"
#import "MultiColumnHeader.h"
#import "Team.h"
#import "Match.h"
#import "StatsAppMacSession.h"
#import "FixtureMatchViewController.h"
#import "Round.h"
#import "Season.h"
#import "Division.h"
#import "SelectTeamViewController.h"
#import "ListPlayersViewController.h"
#import "StatsAppMacNotificationCentre.h"
#import "EditFixtureViewController.h"
#import "EditClubViewController.h"

@class StatsAppMacAppDelegate;

@interface FixtureSearchDelegate : UITableViewController <UISplitViewControllerDelegate> {
    
    UIPopoverController* popOver_;
    UINavigationController* navBar_;
    
}

@property (nonatomic, retain) UIPopoverController* popOver;
@property (nonatomic, retain) IBOutlet UINavigationController* navBar;

- (void) updateFixture;
- (IBAction)editPlayers:(id)sender;
- (IBAction)editFixture:(id)sender;
- (IBAction)editClub:(id)sender;

@end
