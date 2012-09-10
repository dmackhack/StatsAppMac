//
//  SearchGamesViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 4/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchGamesViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
    
    UITableView* tableView_;
}

@property (retain, nonatomic) IBOutlet UITableView* tableView;


@end
