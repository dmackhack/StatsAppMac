//
//  FixtureMatchViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 21/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"
#import "TeamParticipant.h"
#import "Club.h"
#import "Round.h"
#import "Season.h"
#import "Division.h"
#import "Team.h"

@interface FixtureMatchViewController : UIViewController {
    Match* match_;
    Club* club_;
    UILabel* homeTeamLabel_;
    UILabel* awayTeamLabel_;
    UILabel* dateLabel_;
    UILabel* roundLabel_;
    UILabel* divisionLabel_;
}

@property (nonatomic, retain) IBOutlet UILabel* homeTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* awayTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* roundLabel;
@property (nonatomic, retain) IBOutlet UILabel* divisionLabel;
@property (nonatomic, retain) Match* match;
@property (nonatomic, retain) Club* club;

- (void) reloadData;

@end
