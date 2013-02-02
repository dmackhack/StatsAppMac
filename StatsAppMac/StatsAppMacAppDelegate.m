//
//  StatsAppMacAppDelegate.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsAppMacAppDelegate.h"

@implementation StatsAppMacAppDelegate


@synthesize window=_window, repo=repo_, session=session_, notificationCentre=notificationCentre_;


- (SqlLiteRepository*) repo
{
    if (repo_ == nil)
    {
        repo_ = [[SqlLiteRepository alloc] init];
    }
    return repo_;
}

- (StatsAppMacSession*) session
{
    if (session_ == nil)
    {
        session_ = [[StatsAppMacSession alloc] init];
    }
    return session_;
}

- (StatsAppMacNotificationCentre*) notificationCentre
{
    if (notificationCentre_ == nil)
    {
        notificationCentre_ = [[StatsAppMacNotificationCentre alloc] init];
    }
    return notificationCentre_;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"start didFinishLaunchingWithOptions");
    
    //self.statsView = [[GameDayStatsViewController alloc] initWithNibName:@"GameDayStatsViewController" bundle:nil];
    //self.statsView.managedObjectContext = self.managedObjectContext;
    
    // add a navigation view controller programmatically
    MainMenuViewController* mainView = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    
    UINavigationController* mainMenuNav = [[UINavigationController alloc] initWithRootViewController:mainView];
    mainMenuNav.title = @"Main Menu";
    
    self.window.rootViewController = mainMenuNav;
    //self.window.rootViewController = self.statsView;
    [self.window makeKeyAndVisible];
    
    [mainView release];
    //[statsView release];
    
    [self populatePlayerData];
    [self populateTeamData];
        
    [self.repo saveContext];
    
    NSLog(@"end didFinishLaunchingWithOptions");
    
    return YES;
}


- (void)populatePlayerData
{
    NSLog(@"Populating Player Data");
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSArray* players = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing players is: %i", [players count]);
    
    if ([players count] < 4)
    {  
        Player* a = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.repo.managedObjectContext];
        a.firstName = @"David";
        a.lastName = @"Mackenzie";
        
        Player* b = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.repo.managedObjectContext];
        b.firstName = @"Michelle";
        b.lastName = @"Keane";
        
        for (int i = 0; i < 20; i++) 
        {
            Player* temp = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.repo.managedObjectContext];
            temp.firstName = [NSString stringWithFormat:@"FirstName%i", i];
            temp.lastName = [NSString stringWithFormat:@"LastName%i", i];
        }
    }
}

- (void)populateTeamData
{
    NSLog(@"Populating Team Data");
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSArray* clubs = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing clubs is: %i", [clubs count]);
    
    if ([clubs count] < 4)
    {  
        Club* a = [NSEntityDescription insertNewObjectForEntityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext];
        a.name = @"Old Haileybury Amateur Football Club";
        
        Club* b = [NSEntityDescription insertNewObjectForEntityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext];
        b.name = @"Melbourne Demons Football Club";

        for (int i = 0; i < 4; i++) 
        {
            Club* temp = [NSEntityDescription insertNewObjectForEntityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext];
            temp.name = [NSString stringWithFormat:@"Club%i", i];
        }
    }
}


- (void)populateLeagueData
{
    NSLog(@"Populating Team Data");
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"League" inManagedObjectContext:self.repo.managedObjectContext]];
    
    NSArray* clubs = [self.repo.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"Number of existing clubs is: %i", [clubs count]);
    
    if ([clubs count] < 1)
    {  
        League* a = [NSEntityDescription insertNewObjectForEntityForName:@"League" inManagedObjectContext:self.repo.managedObjectContext];
        a.name = @"VAFA";
        
        League* b = [NSEntityDescription insertNewObjectForEntityForName:@"League" inManagedObjectContext:self.repo.managedObjectContext];
        b.name = @"AFL";
        
        for (int i = 0; i < 4; i++) 
        {
            Club* temp = [NSEntityDescription insertNewObjectForEntityForName:@"Club" inManagedObjectContext:self.repo.managedObjectContext];
            temp.name = [NSString stringWithFormat:@"Club%i", i];
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [self.repo saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self.repo saveContext];
}

- (void)dealloc
{
    [_window release];
    [repo_ release];
    [session_ release];
    [notificationCentre_ release];

    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}


@end
