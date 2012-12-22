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

@class StatsAppMacAppDelegate;

@interface FixtureSearchDelegate : UITableViewController {
}

- (void) updateFixture;

@end
