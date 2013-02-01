//
//  ListPlayersViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 29/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlLiteRepository.h"
#import "StatsAppMacSession.h"
#import "Club.h"
#import "CClub.h"
#import "Player.h"
#import "CPlayer.h"
#import "EditPlayerViewController.h"

@class StatsAppMacAppDelegate;

@interface ListPlayersViewController : UITableViewController {
    NSString* cache_;
    NSFetchedResultsController* resultsController_;
}

@property (retain, nonatomic) NSString* cache;

@end
