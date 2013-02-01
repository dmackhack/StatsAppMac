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

@end
