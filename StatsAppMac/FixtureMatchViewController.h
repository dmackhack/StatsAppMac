//
//  FixtureMatchViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 21/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FixtureMatchViewController : UIViewController {
    
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


@end
