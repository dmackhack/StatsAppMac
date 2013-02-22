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
#import "StatsAppMacSession.h"
#import "StatsAppMacNotificationCentre.h"
#import "MainSplitViewController.h"


@interface StatsAppMacAppDelegate : NSObject <UIApplicationDelegate> 
{
    GameDayStatsViewController* statsView_;
    MainMenuViewController* mainView_;
    SqlLiteRepository* repo_;
    StatsAppMacSession* session_;
    StatsAppMacNotificationCentre* notificationCentre_;
    UINavigationController* mainMenuNav_;
    UINavigationController* modalNavBar_;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UINavigationController* mainMenuNav;
@property (nonatomic, retain, readonly) SqlLiteRepository* repo;
@property (nonatomic, retain) StatsAppMacSession* session;
@property (nonatomic, retain) StatsAppMacNotificationCentre* notificationCentre;
@property (nonatomic, retain) UINavigationController* modalNavBar;


- (void) populatePlayerData;
- (void) populateTeamData;

@end
