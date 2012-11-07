//
//  SearchGamesViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 4/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "FixtureSearchDelegate.h"
#import "SqlLiteRepository.h"

@class StatsAppMacAppDelegate;


@interface SearchGamesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate> {
    
    UITableView* tableView_;
    UISearchBar* searchBar_;
    UITableView* fixturesTableView_;
    NSFetchedResultsController* resultsController_;
    NSString* cache_;
    
    FixtureSearchDelegate* fixtureSearchDelegate_;

}

@property (retain, nonatomic) IBOutlet UITableView* tableView;
@property (retain, nonatomic) IBOutlet UISearchBar* searchBar;
@property (retain, nonatomic) IBOutlet UITableView* fixturesTableView;
@property (retain, nonatomic) NSFetchedResultsController* resultsController;
@property (retain, nonatomic) NSString* cache;
@property (retain, nonatomic) FixtureSearchDelegate* fixtureSearchDelegate;

- (StatsAppMacAppDelegate *) appDelegate;


@end
