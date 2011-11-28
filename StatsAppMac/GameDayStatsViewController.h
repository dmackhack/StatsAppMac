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

@class StatsCell;

@interface GameDayStatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
    NSManagedObjectContext* managedObjectContext_;
    NSMutableArray* players_;
}

@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSMutableArray* players;

@end
