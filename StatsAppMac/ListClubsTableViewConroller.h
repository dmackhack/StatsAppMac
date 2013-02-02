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

@class StatsAppMacAppDelegate;

@interface ListClubsTableViewConroller : UITableViewController {
    NSString* cache_;
    NSFetchedResultsController* resultsController_;
}

@property (retain, nonatomic) NSString* cache;

@end
