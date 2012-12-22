//
//  FixtureMatchViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 21/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FixtureMatchViewController : UIViewController {
    
    NSString* homeTeam_;
    NSString* awayTeam_;
    NSString* date_;
    NSString* round_;
    
    UILabel* homeTeamLabel_;
    UILabel* awayTeamLabel_;
    UILabel* dateLabel_;
    UILabel* roundLabel_;
}

@property (nonatomic, retain) NSString* homeTeam;
@property (nonatomic, retain) NSString* awayTeam;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* round;

@property (nonatomic, retain) IBOutlet UILabel* homeTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* awayTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* roundLabel;


@end
