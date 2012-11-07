//
//  FixtureSearchDelegate.h
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "MultiColumnTableCell.h"
#import "Team.h"

@interface FixtureSearchDelegate : UITableViewController {
    Club* selectedClub_;
}

@property (nonatomic, retain) Club* selectedClub;


- (void) updateFixture: (Club*) selectedClub;

@end
