//
//  FixtureMatchViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 21/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FixtureMatchViewController.h"


@implementation FixtureMatchViewController

@synthesize roundLabel=roundLabel_, round=round_, dateLabel=dateLabel_, date=date_, homeTeamLabel=homeTeamLabel_, homeTeam=homeTeam_, awayTeamLabel=awayTeamLabel_, awayTeam=awayTeam_;

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
    [round_ release];
    [roundLabel_ release];
    [dateLabel_ release];
    [date_ release];
    [homeTeam_ release];
    [homeTeamLabel_ release];
    [awayTeam_ release];
    [awayTeamLabel_ release];
    
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

@end