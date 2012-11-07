//
//  StatsAppMacAppDelegate.h
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDayStatsViewController.h"
#import "MainMenuViewController.h"
#import "SqlLiteRepository.h"
#import "Player.h"
#import "Club.h"
#import "Team.h"
#import "League.h"
#import "Division.h"
#import "Season.h"
#import "Round.h"


@interface StatsAppMacAppDelegate : NSObject <UIApplicationDelegate> 
{
    GameDayStatsViewController* statsView_;
    MainMenuViewController* mainView_;
    SqlLiteRepository* repo_;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain, readonly) SqlLiteRepository* repo;



- (void) saveContext;

- (void) populatePlayerData;
- (void) populateTeamData;

@end
