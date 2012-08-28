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


@synthesize gameDayIcon=gameDayIcon_, playesIcon=playersIcon_, clubsIcon=clubsIcon_, statsArchivesIcon=statsArchivesIcon_, anotherIcon=anotherIcon_, settingsIcon=settingsIcon_, managedObjectContext=managedObjectContext_;

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
    return @"<html><body><h2>GAME DAY</h2></body></html>";
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
    GameDayStatsViewController* statsView = [[GameDayStatsViewController alloc] initWithNibName:@"GameDayStatsViewController" bundle:nil];
    
    // TODO figure out a way to get a reference to the managedObjectContext other than passing it around everywhere.
    statsView.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:statsView animated:YES];
    [statsView release];
    NSLog(@"Game Day Clicked END...");
}

@end
