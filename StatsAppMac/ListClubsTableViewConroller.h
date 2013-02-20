//
//  ListClubsTableViewConroller.h
//  StatsAppMac
//
//  Created by David Mackenzie on 15/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlLiteRepository.h"
#import "StatsAppMacSession.h"
#import "Club.h"
#import "StatsAppMacNotificationCentre.h"
#import "ListPlayersViewController.h"
#import "FixtureSearchDelegate.h"

@class StatsAppMacAppDelegate;

@interface ListClubsTableViewConroller : UITableViewController <UISearchBarDelegate> {
    NSString* cache_;
    NSFetchedResultsController* resultsController_;
    UISearchBar* searchBar_;
    
    ListPlayersViewController* listPlayersView_;
    FixtureSearchDelegate* fixtureSearchDelegate_;
    
    
    NSString* searchTerm_;
}

@property (retain, nonatomic) NSString* cache;
@property (nonatomic, retain) IBOutlet UISearchBar* searchBar;
@property (nonatomic, retain) IBOutlet ListPlayersViewController* listPlayersView;
@property (nonatomic, retain) IBOutlet FixtureSearchDelegate* fixtureSearchDelegate;
@property (nonatomic, retain) NSString* searchTerm;

@end
