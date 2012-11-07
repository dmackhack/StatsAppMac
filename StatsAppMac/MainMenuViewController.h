//
//  MainMenuViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlLiteRepository.h"
#import "GameDayStatsViewController.h"
#import "TeamSelectionViewController.h"
#import "SearchGamesViewController.h"

@interface MainMenuViewController : UIViewController {
    
    UIWebView* gameDayIcon_;
    UIWebView* playersIcon_;
    UIWebView* clubsIcon_;
    UIWebView* statsArchivesIcon_;
    UIWebView* anotherIcon_;
    UIWebView* settingsIcon_;
}

@property (nonatomic, retain) IBOutlet UIWebView* gameDayIcon;
@property (nonatomic, retain) IBOutlet UIWebView* playesIcon;
@property (nonatomic, retain) IBOutlet UIWebView* clubsIcon;
@property (nonatomic, retain) IBOutlet UIWebView* statsArchivesIcon;
@property (nonatomic, retain) IBOutlet UIWebView* anotherIcon;
@property (nonatomic, retain) IBOutlet UIWebView* settingsIcon;

- (IBAction)gameDayClicked:(id)sender;
- (IBAction)teamSearchClicked:(id)sender;


@end
