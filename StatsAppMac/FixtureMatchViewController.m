//
//  FixtureMatchViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 21/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FixtureMatchViewController.h"


@implementation FixtureMatchViewController

@synthesize roundLabel=roundLabel_, dateLabel=dateLabel_, homeTeamLabel=homeTeamLabel_, awayTeamLabel=awayTeamLabel_, divisionLabel=divisionLabel_, match=match_, club=club_;

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
    [roundLabel_ release];
    [dateLabel_ release];
    [homeTeamLabel_ release];
    [awayTeamLabel_ release];
    [divisionLabel_ release];
    [match_ release];
    [club_ release];
    
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

- (void) reloadData
{
    
    NSArray* participants = [[self.match participants] allObjects];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE dd MMM yyyy hh:mm aa"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-3540]];
    NSString* dateLabel = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[self.match date]]];
    NSString* homeTeamLabel = [self.club name];
    NSString* awayTeamLabel = @"N/A";
    NSString* divisionLabel = @"N/A";
    
    if ([participants count] == 2)
    {
        TeamParticipant* homeTeam = [self.match homeTeam];
        TeamParticipant* awayTeam = [self.match awayTeam];
        
        homeTeamLabel = [[[homeTeam team] club] name];
        awayTeamLabel = [[[awayTeam team] club] name];
        if (self.match.round.season.division.name == nil)
        {
            divisionLabel = homeTeam.team.name;
        }
        else
        {
            divisionLabel = [NSString stringWithFormat:@"%@ - %@", self.match.round.season.division.name,  homeTeam.team.name];
        }
    }
    
    NSLog(@"Setting values for round: %i", [self.match.round.number intValue]);
    
    self.dateLabel.text = dateLabel;
    self.homeTeamLabel.text = homeTeamLabel;
    self.awayTeamLabel.text = awayTeamLabel;
    self.divisionLabel.text = divisionLabel;
    self.roundLabel.text = [NSString stringWithFormat:@"%i", [self.match.round.number intValue]];
}

@end
