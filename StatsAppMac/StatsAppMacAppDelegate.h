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

@end
