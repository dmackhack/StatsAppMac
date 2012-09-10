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
#import "Player.h"
#import "Club.h"
#import "Team.h"
#import "League.h"

@interface StatsAppMacAppDelegate : NSObject <UIApplicationDelegate> 
{
    GameDayStatsViewController* statsView_;
    MainMenuViewController* mainView_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) saveContext;
- (NSURL *) applicationDocumentsDirectory;
- (void) populatePlayerData;
- (void) populateTeamData;

@end
