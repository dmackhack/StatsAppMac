//
//  StatsCell.h
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Player.h"
#import "CPlayer.h"
#import "PlayerParticipant.h"
#import "CParticipant.h"
#import "FootyPlayerStatistics.h"
#import "CFootyPlayerStatistics.h"
#import "SqlLiteRepository.h"
#import "StatsAppMacNotificationCentre.h"
#import "StatChangedEvent.h"
#import "StatChangedListener.h"

@class StatsAppMacAppDelegate;


@interface StatsCell : UITableViewCell <StatChangedEvent>
{
    
    PlayerParticipant* playerParticipant_;
    
    UILabel* playerName_;
    UILabel* kicksLabel_;
    UILabel* handballsLabel_;
    UILabel* marksLabel_;
    UILabel* tacklesLabel_;
    UILabel* goalsLabel_;
    UILabel* behindsLabel_;
    UILabel* totalScoreLabel_;
    
    id <StatChangedListener> statChangedListener_;
}

@property (nonatomic, retain) PlayerParticipant* playerParticipant;
@property (nonatomic, retain) IBOutlet UILabel* playerName;
@property (nonatomic, retain) IBOutlet UILabel* kicksLabel;
@property (nonatomic, retain) IBOutlet UILabel* handballsLabel;
@property (nonatomic, retain) IBOutlet UILabel* marksLabel;
@property (nonatomic, retain) IBOutlet UILabel* tacklesLabel;
@property (nonatomic, retain) IBOutlet UILabel* goalsLabel;
@property (nonatomic, retain) IBOutlet UILabel* behindsLabel;
@property (nonatomic, retain) IBOutlet UILabel* totalScoreLabel;

@property (nonatomic) id <StatChangedListener> statChangedListener;

- (IBAction)addKick:(id)sender;
- (IBAction)addMark:(id)sender;
- (IBAction)addHandball:(id)sender;
- (IBAction)addTackle:(id)sender;
- (IBAction)addGoal:(id)sender;
- (IBAction)addBehind:(id)sender;

- (void) reloadData;


@end
