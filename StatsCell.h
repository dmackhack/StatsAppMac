//
//  StatsCell.h
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "PlayerParticipant.h"
#import "CParticipant.h"
#import "FootyPlayerStatistics.h"
#import "SqlLiteRepository.h"

@class Player;
@class StatsAppMacAppDelegate;

@interface StatsCell : UITableViewCell
{
    
    PlayerParticipant* playerParticipant_;
    
    UILabel* playerName_;
    UILabel* kicksLabel_;
    UILabel* handballsLabel_;
    UILabel* marksLabel_;
    UILabel* tacklesLabel_;
}

@property (nonatomic, retain) PlayerParticipant* playerParticipant;
@property (nonatomic, retain) IBOutlet UILabel* playerName;
@property (nonatomic, retain) IBOutlet UILabel* kicksLabel;
@property (nonatomic, retain) IBOutlet UILabel* handballsLabel;
@property (nonatomic, retain) IBOutlet UILabel* marksLabel;
@property (nonatomic, retain) IBOutlet UILabel* tacklesLabel;


- (IBAction)addKick:(id)sender;
- (IBAction)addMark:(id)sender;
- (IBAction)addHandball:(id)sender;
- (IBAction)addTackle:(id)sender;

- (void) reloadData;


@end
