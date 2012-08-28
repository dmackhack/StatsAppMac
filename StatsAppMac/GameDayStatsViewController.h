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

@class StatsAppMacAppDelegate;
@class StatsCell;

@interface GameDayStatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate> 
{
    NSFetchedResultsController* resultsController_;
    NSString* cache_;
}

@property (nonatomic, readonly) NSFetchedResultsController* resultsController;
@property (nonatomic, retain) NSString* cache;

- (StatsAppMacAppDelegate *) appDelegate;

@end
