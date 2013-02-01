//
//  MainMenuViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"


@interface MainMenuViewController()

- (NSString*) prepareGameDayText;

@end


@implementation MainMenuViewController


@synthesize gameDayIcon=gameDayIcon_, playesIcon=playersIcon_, clubsIcon=clubsIcon_, statsArchivesIcon=statsArchivesIcon_, anotherIcon=anotherIcon_, settingsIcon=settingsIcon_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"viewDidLoad");
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [gameDayIcon_ loadHTMLString:[self prepareGameDayText] baseURL:baseURL];
}


    
- (NSString *)prepareGameDayText
{
    return @"<html><body style='background-color: #003366'><h2 style='font: 15px verdana,arial,helvetica,sans-serif; color: #FFFFFF;'>Game Day</h2></body></html>";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)gameDayClicked:(id)sender 
{
    NSLog(@"Game Day Clicked");
    //GameDayStatsViewController* statsView = [[GameDayStatsViewController alloc] initWithNibName:@"GameDayStatsViewController" bundle:nil];
    TeamSelectionViewController* teamSelectionView = [[TeamSelectionViewController alloc] initWithNibName:@"TeamSelectionViewController" bundle:nil];
    
    // TODO figure out a way to get a reference to the managedObjectContext other than passing it around everywhere.
    [self.navigationController pushViewController:teamSelectionView animated:YES];
    //[statsView release];
    [teamSelectionView release];
    NSLog(@"Game Day Clicked END...");
}

- (IBAction)teamSearchClicked:(id)sender
{
    NSLog(@"Team Search Clicked");
    SearchGamesViewController* searchGamesView = [[SearchGamesViewController alloc] initWithNibName:@"SearchGamesViewController" bundle:nil];
    
    [self.navigationController pushViewController:searchGamesView animated:YES];
    [searchGamesView release];
    
}

- (IBAction)selectTeamClicked:(id)sender
{
    NSLog(@"Select Team Clicked");
    SelectTeamViewController* selectTeamView = [[SelectTeamViewController alloc] initWithNibName:@"SelectTeamViewController" bundle:nil];
    
    [self.navigationController pushViewController:selectTeamView animated:YES];
    [selectTeamView release];
}

- (IBAction)adminPlayersClicked:(id)sender
{
    NSLog(@"Admin Players Clicked");
    
    AdminPlayersViewController* adminPlayersView = [[AdminPlayersViewController alloc] initWithNibName:@"AdminPlayersViewController" bundle:nil];
    
    [self.navigationController pushViewController:adminPlayersView animated:YES];
    [adminPlayersView release];
    

}

@end
