//
//  EditClubViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/04/13.
//
//

#import "EditClubViewController.h"

@interface EditClubViewController ()

@end

@implementation EditClubViewController

@synthesize club=club_,clubDetailsView=clubDetailsView_, teamsTableView=teamsTableView_, clubNameTextField=clubNameTextField_, addTeamButton=addTeamButton_;

Team* selectedTeam;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.clubDetailsView.layer.masksToBounds = NO;
    self.clubDetailsView.layer.cornerRadius = 10;
    self.clubDetailsView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.clubDetailsView.layer.shadowRadius = 5;
    self.clubDetailsView.layer.shadowOpacity = 0.5;
    
    UIBarButtonItem* save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.title = @"Club Details";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.club != nil)
    {
        self.clubNameTextField.text = self.club.name;
    }
    selectedTeam = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [club_ release];
    [clubDetailsView_ release];
    [teamsTableView_ release];
    [clubNameTextField_ release];
    [addTeamButton_ release];
    [super dealloc];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (section == 0 && self.club != nil && self.club.teams != nil)
    {
        count = [self.club.teams count];
    }
    return count;
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeamCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    Team* team = [[self.club.teams allObjects] objectAtIndex:indexPath.row];
    cell.textLabel.text = team.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedTeam = [[self.club.teams allObjects] objectAtIndex:indexPath.row];
    self.teamNameTextField.text = selectedTeam.name;
    self.addTeamButton.style = UIBarButtonSystemItemEdit;
    self.addTeamButton.title = @"Edit";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Teams";
    }
    else
    {
        return @"";
    }
}

- (IBAction)cancel:(id)sender
{
    [[[self repo] managedObjectContext] undo];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    if (self.club != nil)
    {
        self.club.name = self.clubNameTextField.text;
        [[self repo] saveContext];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)addTeam:(id)sender
{
    if (self.teamNameTextField.text != nil)
    {
        if (selectedTeam == nil)
        {
            [self.club addNewTeam:self.teamNameTextField.text withRepository:[self repo]];
        }
        else
        {
            selectedTeam.name = self.teamNameTextField.text;
        }
        self.teamNameTextField.text = nil;
        selectedTeam = nil;
        self.addTeamButton.style = UIBarButtonSystemItemAdd;
        self.addTeamButton.title = @"Add";
        [self.teamsTableView reloadData];
    }
}


@end
