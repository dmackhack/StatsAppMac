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
    [super viewWillAppear:animated];
    selectedHomeTeam = nil;
    selectedAwayTeam = nil;
    [self.roundPickerController viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    selectedHomeTeam = nil;
    selectedAwayTeam = nil;
    match_ = nil;
    [super viewDidDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.match != nil)
    {
        NSNumber* homeClubIndex = [self clubIndex:self.match.homeTeam.team.club.name];
        NSNumber* awayClubIndex = [self clubIndex:self.match.awayTeam.team.club.name];
        NSNumber* homeTeamIndex = [self teamIndexForClub:self.match.homeTeam.team.club andTeam:self.match.homeTeam.team.name];
        NSNumber* awayTeamIndex = [self teamIndexForClub:self.match.awayTeam.team.club andTeam:self.match.awayTeam.team.name];
        
        [self.homeTeamPicker selectRow:[homeClubIndex integerValue] inComponent:0 animated:NO];
        [self.awayTeamPicker selectRow:[awayClubIndex integerValue] inComponent:0 animated:NO];
        [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
        [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
        [self.homeTeamPicker selectRow:[homeTeamIndex integerValue] inComponent:1 animated:NO];
        [self.awayTeamPicker selectRow:[awayTeamIndex integerValue] inComponent:1 animated:NO];
        
        self.datePicker.date = self.match.date;
        self.roundTextField.text = self.match.round.number.stringValue;
    }
    else
    {
        [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
        [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
    }
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
    else if (pickerView == self.roundPicker)
    {
        return 1;
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
                NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                count = [club.teams count];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                count = [club.teams count];
            }
        }
    }
    else if (pickerView == self.roundPicker)
    {
        count = 1;
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
            Club* club;
            if (pickerView == self.homeTeamPicker)
            {
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
            }
            title = club.name;
        
        }
        else if (component == 1)
        {
            Club* club;
            NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            if (pickerView == self.homeTeamPicker)
            {
                NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
            }
            Team* team = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
            title = team.name;
            [nameSort release];
        }
    }
    else if (pickerView == self.roundPicker)
    {
        if (component == 0)
        {
            title = @"1";
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
                [self.homeTeamPicker reloadComponent:1];
                [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
            }
            else if (pickerView == self.awayTeamPicker)
            {
                [self.awayTeamPicker reloadComponent:1];
                [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
            }
        }
    
        else if (component == 1)
        {
            Club* club;
            NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            if (pickerView == self.homeTeamPicker)
            {
                NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                if ([club.teams count] > 0)
                {
                    selectedHomeTeam = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
                }
                else
                {
                    selectedHomeTeam = nil;
                }
                NSLog(@"Setting selected home team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
            }
            else if (pickerView == self.awayTeamPicker)
            {
                NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
                club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
                if ([club.teams count] > 0)
                {
                    selectedAwayTeam = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
                }
                else
                {
                    selectedAwayTeam = nil;
                }
                NSLog(@"Setting selected away team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
            }
            [nameSort release];
            [club release];
        }
    }
    else if (pickerView == self.roundPicker)
    {
        if (component == 0)
        {
            
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
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
