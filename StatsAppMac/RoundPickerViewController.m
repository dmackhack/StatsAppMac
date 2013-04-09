//
//  RoundPickerViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 8/04/13.
//
//

#import "RoundPickerViewController.h"
#import "League.h"
#import "Division.h"
#import "Season.h"
#import "Round.h"

@implementation RoundPickerViewController

const int LEAGUE_COMPONENT = 0;
const int DIVISION_COMPONENT = 1;
const int SEASON_COMPONENT = 2;
const int ROUND_COMPONENT = 3;

League* selectedLeague;
Division* selectedDivision;
Season* selectedSeason;
Round* selectedRound;

NSArray* leagues;


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (FixtureSqlLiteRepository*) fixtureRepo
{
    return [[self appDelegate] fixtureRepo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    leagues = [[self fixtureRepo] fetchLeaguesByName:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    leagues = nil;
    selectedLeague = nil;
    
    [super viewWillDisappear:animated];
}

-(void)dealloc
{
    [selectedLeague release];
    [leagues release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int count = 0;
    if (component == LEAGUE_COMPONENT)
    {
        count = [[[self fixtureRepo] fetchLeaguesByName:nil] count];
    }
    else if (component == DIVISION_COMPONENT)
    {
        if (selectedLeague != nil)
        {
            count = [[selectedLeague divisions] count];
        }
    }
    else if (component == SEASON_COMPONENT)
    {
        if (selectedDivision != nil)
        {
            count = [selectedDivision.seasons count];
        }
    }
    else if (component == ROUND_COMPONENT)
    {
        if (selectedSeason != nil)
        {
            count = [selectedSeason.rounds count];
        }
    }
        
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title = @"";

    if (component == LEAGUE_COMPONENT)
    {
        League* league = [[[self fixtureRepo] fetchLeaguesByName:nil] objectAtIndex:row];
        title = league.name;
    }
    else if (component == DIVISION_COMPONENT)
    {
        if (selectedLeague != nil && [selectedLeague.divisions count] > 0)
        {
            title = [[[[selectedLeague divisions] allObjects] objectAtIndex:row] name];
        }
    }
    else if (component == SEASON_COMPONENT)
    {
        if (selectedDivision != nil && [selectedDivision.seasons count] > 0)
        {
            Season* season = [[selectedDivision.seasons allObjects] objectAtIndex:row];
            title = [season year];
        }
    }
    else if (component == ROUND_COMPONENT)
    {
        if (selectedSeason != nil && [selectedSeason.rounds count] > 0)
        {
            Round* round = [[selectedSeason.rounds allObjects] objectAtIndex:row];
            title = [[round number] stringValue];
        }
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == LEAGUE_COMPONENT)
    {
        selectedLeague = [[[self fixtureRepo] fetchLeaguesByName:nil] objectAtIndex:row];
        [pickerView reloadAllComponents];
    }
    else if (component == DIVISION_COMPONENT)
    {
        selectedDivision = [[[selectedLeague divisions] allObjects] objectAtIndex:row];
        [pickerView reloadAllComponents];
    }
    else if (component == SEASON_COMPONENT)
    {
        selectedSeason = [[[selectedDivision seasons] allObjects] objectAtIndex:row];
        [pickerView reloadAllComponents];
    }
}

@end
