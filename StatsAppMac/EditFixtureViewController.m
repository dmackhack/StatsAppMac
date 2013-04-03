//
//  EditFixtureViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 15/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "EditFixtureViewController.h"


@implementation EditFixtureViewController

@synthesize roundTextField=roundTextField_, datePicker=datePicker_, homeTeamPicker=homeTeamPicker_, awayTeamPicker=awayTeamPicker_;


Team* selectedHomeTeam;
Team* selectedAwayTeam;


- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
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

-(void)viewWillAppear:(BOOL)animated
{
    selectedHomeTeam = nil;
    selectedAwayTeam = nil;

    [self pickerView:self.homeTeamPicker didSelectRow:0 inComponent:1];
    [self pickerView:self.awayTeamPicker didSelectRow:0 inComponent:1];
}

-(void)viewDidDisappear:(BOOL)animated
{
    selectedHomeTeam = nil;
    selectedAwayTeam = nil;
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
    else
    {
        return 2;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int count = 0;
    if (component == 0)
    {
        if (pickerView == self.homeTeamPicker)
        {
            count = [[[[self appDelegate] clubRepo] fetchClubs:nil] count];
        }
        else
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
        else
        {
            NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
            count = [club.teams count];
        }
    }
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title = @"";
    if (component == 0)
    {
        Club* club;
        if (pickerView == self.homeTeamPicker)
        {
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
        }
        else
        {   
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:row];
        }
        title = club.name;
    }
    else
    {
        Club* club;
        NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        if (pickerView == self.homeTeamPicker)
        {
            NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
        }
        else
        {   
            NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
        }
        Team* team = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
        title = team.name;
        [nameSort release];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
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
    
    if (component == 1)
    {
        Club* club;
        NSSortDescriptor* nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        if (pickerView == self.homeTeamPicker)
        {
            NSInteger selectedRow = [self.homeTeamPicker selectedRowInComponent:0];
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
            selectedHomeTeam = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
            NSLog(@"Setting selected home team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
        }
        else if (pickerView == self.awayTeamPicker)
        {
            NSInteger selectedRow = [self.awayTeamPicker selectedRowInComponent:0];
            club = [[[[self appDelegate] clubRepo] fetchClubs:nil] objectAtIndex:selectedRow];
            selectedAwayTeam = [[club.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]] objectAtIndex:row];
            NSLog(@"Setting selected away team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
        }
        [nameSort release];
        [club release];
    }
}


- (IBAction)cancel:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Selected Home Team: %@ - %@", selectedHomeTeam.club.name, selectedHomeTeam.name);
    NSLog(@"Selected Away Team: %@ - %@", selectedAwayTeam.club.name, selectedAwayTeam.name);
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
