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

@synthesize match=match_, roundPicker=roundPicker_, selectedRound=selectedRound_;

const int LEAGUE_COMPONENT = 0;
const int DIVISION_COMPONENT = 1;
const int SEASON_COMPONENT = 2;
const int ROUND_COMPONENT = 3;

League* selectedLeague;
int selectedLeagueIndex=0;
Division* selectedDivision;
int selectedDivisionIndex=0;
Season* selectedSeason;
int selectedSeasonIndex=0;
//Round* selectedRound;
int selectedRoundIndex=0;

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
    NSLog(@"RoundPickerViewController View Will Appear: %d", selectedRoundIndex);
    [super viewWillAppear:animated];

    [self.roundPicker selectRow:selectedLeagueIndex inComponent:LEAGUE_COMPONENT animated:NO];
    [self.roundPicker selectRow:selectedDivisionIndex inComponent:DIVISION_COMPONENT animated:NO];
    [self.roundPicker selectRow:selectedSeasonIndex inComponent:SEASON_COMPONENT animated:NO];
    [self.roundPicker selectRow:selectedRoundIndex inComponent:ROUND_COMPONENT animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    leagues = nil;
    selectedLeague = nil;
    selectedDivision = nil;
    selectedSeason = nil;
    self.selectedRound = nil;
    match_ = nil;
    
    [super viewWillDisappear:animated];
}

-(void)dealloc
{
    [match_ release];
    [roundPicker_ release];
    [selectedRound_ release];
    
    [super dealloc];
}

- (id)initWithMatch:(Match*)match andPicker:(UIPickerView*)pickerView
{
    self = [super init];
    if (self) {
        // Custom initialization
        NSLog(@"In Init...");
        self.roundPicker = pickerView;
        self.match = match;
        leagues = [[self fixtureRepo] fetchLeaguesByName:nil];
        if (self.match != nil)
        {
            self.selectedRound = self.match.round;
            selectedSeason = self.selectedRound.season;
            selectedDivision = selectedSeason.division;
            selectedLeague = selectedDivision.league;
            
            selectedRoundIndex = [[selectedSeason.rounds allObjects] indexOfObject:self.selectedRound];
            selectedSeasonIndex = [[selectedDivision.seasons allObjects] indexOfObject:selectedSeason];
            selectedDivisionIndex = [[selectedLeague.divisions allObjects] indexOfObject:selectedDivision];
            selectedLeagueIndex = [leagues indexOfObject:selectedLeague];
        }
        else
        {
            //self.selectedRound = nil;
            //selectedSeason = nil;
            //selectedDivision = nil;
            //selectedLeague = nil;
            
            [self pickerView:self.roundPicker didSelectRow:0 inComponent:0];
            
            selectedRoundIndex = 0;
            selectedSeasonIndex = 0;
            selectedDivisionIndex = 0;
            selectedLeagueIndex = 0;
        }
    }
    return self;
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
        count = [leagues count];
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
        League* league = [leagues objectAtIndex:row];
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
        selectedLeague = [leagues objectAtIndex:row];
        if (selectedLeague != nil && [[selectedLeague divisions] count] > 0)
        {
            selectedDivision = [[[selectedLeague divisions] allObjects] objectAtIndex:0];
        }
        else
        {
            selectedDivision = nil;
        }
        if (selectedDivision != nil && [[selectedDivision seasons] count] > 0)
        {
            selectedSeason = [[[selectedDivision seasons] allObjects] objectAtIndex:0];
        }
        else
        {
            selectedSeason = nil;
        }
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[[selectedSeason rounds] allObjects] objectAtIndex:0];
        }
        else
        {
            self.selectedRound = nil;
        }
        
        [pickerView reloadAllComponents];

    }
    else if (component == DIVISION_COMPONENT)
    {
        selectedDivision = [[[selectedLeague divisions] allObjects] objectAtIndex:row];
        if (selectedDivision != nil && [[selectedDivision seasons] count] > 0)
        {
            selectedSeason = [[[selectedDivision seasons] allObjects] objectAtIndex:0];
        }
        else
        {
            selectedSeason = nil;
        }
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[[selectedSeason rounds] allObjects] objectAtIndex:0];
        }
        else
        {
            self.selectedRound = nil;
        }
        
        [pickerView reloadAllComponents];
    }
    else if (component == SEASON_COMPONENT)
    {
        selectedSeason = [[[selectedDivision seasons] allObjects] objectAtIndex:row];
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[[selectedSeason rounds] allObjects] objectAtIndex:0];
        }
        else
        {
            self.selectedRound = nil;
        }
        
        [pickerView reloadAllComponents];
    }
    else if (component == ROUND_COMPONENT)
    {
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[[selectedSeason rounds] allObjects] objectAtIndex:row];
        }
        else
        {
            self.selectedRound = nil;
        }
    }
}

@end
