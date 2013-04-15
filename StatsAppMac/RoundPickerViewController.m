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

- (NSArray*) fetchLeagues
{
    return [[self fixtureRepo] fetchLeaguesByName:nil];
}

- (NSArray*) fetchDivisions
{
    NSArray* divisions;
    if (selectedLeague != nil)
    {
        NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        divisions = [[[selectedLeague divisions] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
        [nameSort release];
    }
    else
    {
        divisions = nil;
    }
    return divisions;
}

- (NSArray*) fetchSeasons
{
    NSArray* seasons;
    if (selectedDivision != nil)
    {
        NSSortDescriptor* yearSort = [[NSSortDescriptor alloc] initWithKey:@"year" ascending:YES];
        seasons = [[[selectedDivision seasons] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:yearSort, nil]];
        [yearSort release];
    }
    else
    {
        seasons = nil;
    }
    return seasons;
}

- (NSArray*) fetchRounds
{
    NSArray* rounds;
    if (selectedSeason != nil)
    {
        NSSortDescriptor* roundSort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
        rounds = [[[selectedSeason rounds] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:roundSort, nil]];
        [roundSort release];
    }
    else
    {
        rounds = nil;
    }
    return rounds;
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
        leagues = [self fetchLeagues];
        if (self.match != nil)
        {
            if (self.match.round != nil)
            {
                self.selectedRound = self.match.round;
            }
            else
            {
                self.selectedRound = nil;
                selectedRoundIndex = 0;
            }
            if (self.selectedRound != nil && self.selectedRound.season != nil)
            {
                selectedSeason = self.selectedRound.season;
                selectedRoundIndex = [[self fetchRounds] indexOfObject:self.selectedRound];
            }
            else
            {
                selectedSeason = nil;
                selectedSeasonIndex = 0;
            }
            if (selectedSeason != nil && selectedSeason.division != nil)
            {
                selectedDivision = selectedSeason.division;
                selectedSeasonIndex = [[self fetchSeasons] indexOfObject:selectedSeason];
            }
            else
            {
                selectedDivision = nil;
                selectedDivisionIndex = 0;
            }
            if (selectedDivision != nil && selectedDivision.league !=nil)
            {
                selectedLeague = selectedDivision.league;
                selectedLeagueIndex = [leagues indexOfObject:selectedLeague];
                selectedDivisionIndex = [[self fetchDivisions] indexOfObject:selectedDivision];
            }
            else
            {
                selectedLeague = nil;
                selectedLeagueIndex = 0;
            }
        }
        else
        {
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
            title = [[[self fetchDivisions] objectAtIndex:row] name];
        }
    }
    else if (component == SEASON_COMPONENT)
    {
        if (selectedDivision != nil && [selectedDivision.seasons count] > 0)
        {
            Season* season = [[self fetchSeasons] objectAtIndex:row];
            title = [season year];
        }
    }
    else if (component == ROUND_COMPONENT)
    {
        if (selectedSeason != nil && [selectedSeason.rounds count] > 0)
        {
            Round* round = [[self fetchRounds] objectAtIndex:row];
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
            selectedDivision = [[self fetchDivisions] objectAtIndex:0];
        }
        else
        {
            selectedDivision = nil;
        }
        if (selectedDivision != nil && [[selectedDivision seasons] count] > 0)
        {
            selectedSeason = [[self fetchSeasons] objectAtIndex:0];
        }
        else
        {
            selectedSeason = nil;
        }
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[self fetchRounds] objectAtIndex:0];
        }
        else
        {
            self.selectedRound = nil;
        }
        
        [pickerView reloadAllComponents];

    }
    else if (component == DIVISION_COMPONENT)
    {
        selectedDivision = [[self fetchDivisions] objectAtIndex:row];
        if (selectedDivision != nil && [[selectedDivision seasons] count] > 0)
        {
            selectedSeason = [[self fetchSeasons] objectAtIndex:0];
        }
        else
        {
            selectedSeason = nil;
        }
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[self fetchRounds] objectAtIndex:0];
        }
        else
        {
            self.selectedRound = nil;
        }
        
        [pickerView reloadAllComponents];
    }
    else if (component == SEASON_COMPONENT)
    {
        selectedSeason = [[self fetchSeasons] objectAtIndex:row];
        if (selectedSeason != nil && [[selectedSeason rounds] count] > 0)
        {
            self.selectedRound = [[self fetchRounds] objectAtIndex:0];
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
            self.selectedRound = [[self fetchRounds] objectAtIndex:row];
        }
        else
        {
            self.selectedRound = nil;
        }
    }
}

@end
