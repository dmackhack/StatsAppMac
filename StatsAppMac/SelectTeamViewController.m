//
//  SelectTeamViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 5/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectTeamViewController.h"


@implementation SelectTeamViewController

@synthesize availablePlayersTableView=availablePlayersTableView_, selectedTeamTableView=selectedTeamTableView_, checkedAvailablePlayers=checkedAvailablePlayers_, checkedSelectedPlayers=checkedSelectedPlayers_;

- (StatsAppMacAppDelegate*) appDelegate
{
    return (StatsAppMacAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
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
    [availablePlayersTableView_ release];
    [selectedTeamTableView_ release];
    [checkedAvailablePlayers_ release];
    [checkedSelectedPlayers_ release];
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
    if (self.checkedAvailablePlayers == nil)
    {
        self.checkedAvailablePlayers = [[NSMutableArray alloc] init];
    }
    if (self.checkedSelectedPlayers == nil)
    {
        self.checkedSelectedPlayers = [[NSMutableArray alloc] init];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"ViewWillAppear");
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    // save the players.
    NSLog(@"Clear checked lists");
    
    [self.checkedAvailablePlayers removeAllObjects];
    [self.checkedSelectedPlayers removeAllObjects];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (TeamParticipant*) selectedTeamParticipant
{
    if ([[self session] selectedMatch] != nil && [[self session] selectedClub] != nil)
    {
        NSLog(@"Found Team Part");
        return [[[self session] selectedMatch] teamParticipantForClub:[[self session] selectedClub]];
    }
    else
    {
        NSLog(@"Found Team Part Nil");
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (tableView == self.availablePlayersTableView)
    {
        count = [[[[self session] selectedClub] currentPlayers] count];
    }
    else
    {
        if ([self selectedTeamParticipant] != nil)
        {
            int numPlayers = [[[self selectedTeamParticipant] playerParticipants] count];
            NSLog(@"Number of players in team: %i", numPlayers);
            count = [[[self selectedTeamParticipant] playerParticipants] count];
        }
        else
        {
            count = 0;
        }
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (tableView == self.availablePlayersTableView)
    {
        static NSString *CellIdentifier = @"AvailablePlayerCell";
        cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            
            Player* player = [[[[self session] selectedClub] currentPlayers] objectAtIndex:indexPath.row];
            cell.textLabel.text = [player displayName];
        }
    }
    else
    {
        static NSString *CellIdentifier = @"SelectedPlayerCell";
        cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            
            PlayerParticipant* participant = [[[[self selectedTeamParticipant] playerParticipants] allObjects] objectAtIndex:indexPath.row];
            cell.textLabel.text = [[participant player] displayName];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.availablePlayersTableView)
    {
        if (cell.accessoryType == UITableViewCellAccessoryNone) 
        {
            [self.checkedAvailablePlayers addObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } 
        else 
        {
            [self.checkedAvailablePlayers removeObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    if (tableView == self.selectedTeamTableView)
    {
        if (cell.accessoryType == UITableViewCellAccessoryNone) 
        {
            [self.checkedSelectedPlayers addObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } 
        else 
        {
            [self.checkedSelectedPlayers removeObject:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == [self availablePlayersTableView])
    {
        return @"Available Players";
    }
    else
    {
        return @"Selected Players";
    }
}

- (IBAction)addPlayersToTeam:(id)sender
{
    NSLog(@"Add the following players: %@ ", [self checkedAvailablePlayers]);
    for (NSIndexPath* index in [self checkedAvailablePlayers])
    {
        Player* player = [[[[self session] selectedClub] currentPlayers] objectAtIndex:index.row];
        NSLog(@"Add the following player: %@ ", [player displayName]);
    }
        
}

- (IBAction)removePlayersFromTeam:(id)sender
{
    NSLog(@"Remove the following players: %@ ", [self checkedSelectedPlayers]);
}

@end
