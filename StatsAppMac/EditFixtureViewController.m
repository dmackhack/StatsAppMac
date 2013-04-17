//
//  EditFixtureViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 15/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EditFixtureViewController.h"


@implementation EditFixtureViewController

@synthesize roundTextField=roundTextField_, datePicker=datePicker_, homeTeamPicker=homeTeamPicker_, awayTeamPicker=awayTeamPicker_, match=match_, roundPicker=roundPicker_, roundPickerController=roundPickerController_;


Club* selectedHomeClub;
Club* selectedAwayClub;
Team* selectedHomeTeam;
Team* selectedAwayTeam;


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (SqlLiteRepository*) repo
{
    return [[self appDelegate] repo];
}

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
    [roundTextField_ release];
    [datePicker_ release];
    [homeTeamPicker_ release];
    [awayTeamPicker_ release];
    [roundPicker_ release];
    [match_ release];
    
    [roundPickerController_ release];
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
    
    if (roundPickerController_ == nil)
    {
        roundPickerController_ = [[RoundPickerViewController alloc] initWithMatch:self.match andPicker:self.roundPicker];
    }
    
    self.roundPicker.delegate = self.roundPickerController;
    self.roundPicker.dataSource = self.roundPickerController;
    //[self.roundPickerController init];
    
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    roundPickerController_ = nil;
}

-(NSNumber*) clubIndex:(NSString*) name;
{
    int index = 0;
    for (Club* club in [[[self appDelegate] clubRepo] fetchClubs:nil])
    {
        if ([name isEqualToString:club.name])
        {
            NSLog(@"Found Index for Club %@ at Index %d", name, index);
            break;
        }
        index++;
    }
    return [NSNumber numberWithInt:index];
}

-(NSNumber*) teamIndexForClub:(Club*)club andTeam:(NSString*) name
{
    int index = 0;
    NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    for (Team* team in [club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]])
    {
        //NSLog(@"%@:%@", name, team.name);
        if ([name isEqualToString:team.name])
        {
            NSLog(@"Found Index for Team %@ for Club %@ at Index %d", name, club.name, index);
            break;
        }
        index++;
    }
    [nameSort release];
    return [NSNumber numberWithInt:index];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (self.match != nil)
    {
        selectedHomeTeam = self.match.homeTeam.team;
        selectedAwayTeam = self.match.awayTeam.team;
        selectedHomeClub = selectedHomeTeam.club;
        selectedAwayClub = selectedAwayTeam.club;
        NSNumber* homeClubIndex = [self clubIndex:selectedHomeClub.name];
        NSNumber* awayClubIndex = [self clubIndex:selectedAwayClub.name];
        NSNumber* homeTeamIndex = [self teamIndexForClub:selectedHomeClub andTeam:selectedHomeTeam.name];
        NSNumber* awayTeamIndex = [self teamIndexForClub:selectedAwayClub andTeam:selectedAwayTeam.name];
        
        [self.homeTeamPicker selectRow:[homeClubIndex integerValue] inComponent:0 animated:NO];
        [self.awayTeamPicker selectRow:[awayClubIndex integerValue] inComponent:0 animated:NO];
        //[self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
        //[self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
        [self.homeTeamPicker selectRow:[homeTeamIndex integerValue] inComponent:1 animated:NO];
        [self.awayTeamPicker selectRow:[awayTeamIndex integerValue] inComponent:1 animated:NO];
        
        self.datePicker.date = self.match.date;
        self.roundTextField.text = self.match.round.number.stringValue;
    }
    else
    {
        selectedHomeClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:0];
        selectedAwayClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:0];
        //[self.homeTeamPicker selectRow:0 inComponent:0 animated:NO];
        //[self pickerView:self.awayTeamPicker selectRow:0 inComponent:1];
    }
    [super viewWillAppear:animated];
    [self.roundPickerController viewWillAppear:animated];    
}

-(void)viewDidDisappear:(BOOL)animated
{
    selectedHomeTeam = nil;
    selectedAwayTeam = nil;
    selectedHomeClub = nil;
    selectedAwayClub = nil;
    match_ = nil;
    [super viewDidDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.homeTeamPicker)
    {
        return 2;
    }
    else if (pickerView == self.awayTeamPicker)
    {
        return 2;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int count = 0;
    if (pickerView == self.homeTeamPicker || pickerView == self.awayTeamPicker)
    {
        if (component == 0)
        {
            if (pickerView == self.homeTeamPicker)
            {
                count = [[[[self appDelegate] clubRepo] fetchClubs:nil] count];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                count = [[[[self appDelegate] clubRepo] fetchClubs:nil] count];
            }
        }
        else if (component == 1)
        {
            Club* club;
            if (pickerView == self.homeTeamPicker)
            {
                //NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                //count = [club.teams count];
                if (selectedHomeClub != nil)
                {
                    count = [[selectedHomeClub teams] count];
                }
            }
            else if (pickerView == self.awayTeamPicker)
            {
                //NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                //count = [club.teams count];
                if (selectedAwayClub != nil)
                {
                    count = [[selectedAwayClub teams] count];
                }
            }
        }
    }
    
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title = @"";
    if (pickerView == self.homeTeamPicker || pickerView == self.awayTeamPicker)
    {
        if (component == 0)
        {
            Club* club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
            title = club.name;
        
        }
        else if (component == 1)
        {
            Club* club;
            NSArray* teams;
            NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            if (pickerView == self.homeTeamPicker)
            {
                //NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                if (selectedHomeClub != nil)
                {
                    teams = [selectedHomeClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
                }
            }
            else if (pickerView == self.awayTeamPicker)
            {
                //NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                //club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                if (selectedAwayClub != nil)
                {
                    teams = [selectedAwayClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
                }
            }
            
            //Team* team = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
            Team* team = [teams objectAtIndex:row];
            title = team.name;
            [nameSort release];
        }
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.homeTeamPicker || pickerView == self.awayTeamPicker)
    {
        if (component == 0)
        {
            if (pickerView == self.homeTeamPicker)
            {
                selectedHomeClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
                [self.homeTeamPicker reloadComponent:1];
                [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                selectedAwayClub = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
                [self.awayTeamPicker reloadComponent:1];
                [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
            }
        }
    
        else if (component == 1)
        {
            NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            if (pickerView == self.homeTeamPicker)
            {
                if (selectedHomeClub != nil && [selectedHomeClub.teams count] > 0)
                {
                    selectedHomeTeam = [[selectedHomeClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
                }
                else
                {
                    selectedHomeTeam = nil;
                }
                NSLog(@"Setting selected home team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
            }
            else if (pickerView == self.awayTeamPicker)
            {
                if (selectedAwayClub != nil && [selectedAwayClub.teams count] > 0)
                {
                    selectedAwayTeam = [[selectedAwayClub.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
                }
                else
                {
                    selectedAwayTeam = nil;
                }
                NSLog(@"Setting selected away team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
            }
            [nameSort release];
        }
    }
}


- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Selected Home Team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
    NSLog(@"Selected Away Team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
    
    Match* match = self.match;
    if (match == nil)
    {
        match = [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:[self repo].managedObjectContext];
        [match createMatchParticipantsWithRepository:[self repo] homeTeam:selectedHomeTeam awayTeam:selectedAwayTeam];
    
        Round* round = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:[self repo].managedObjectContext];
        match.round = round;
        [round addMatchesObject:match];
    }
    NSDate* date = [self.datePicker date];
    // this will change all round numbers and dates for every team in that fixture. Really need to implment the Picker to avoid this !!!
    if (self.roundPickerController.selectedRound != nil)
    {
        match.round = self.roundPickerController.selectedRound;
    }
    else
    {
        match.round.number = [NSNumber numberWithInt:[[self.roundTextField text] integerValue]];
        match.round.date = date;
    }
    match.date = date;
    
    [[self repo] saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
