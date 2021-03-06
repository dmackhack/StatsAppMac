//
//  FixtureSearchDelegate.m
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FixtureSearchDelegate.h"


@implementation FixtureSearchDelegate

@synthesize popOver=popOver_, navBar=navBar_;

- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (StatsAppMacSession*) session
{
    return [[self appDelegate] session];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [popOver_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) updateFixture;
{
    [self.tableView reloadData];
    
    if (self.popOver != nil)
    {
        [self.popOver dismissPopoverAnimated:YES];
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[self appDelegate] setDefaultClub];
    
    UIBarButtonItem* editPlayers = [[UIBarButtonItem alloc] initWithTitle:@"Players" style:UIBarButtonItemStyleBordered target:self action:@selector(editPlayers:)];
    UIBarButtonItem* editFixture = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(editFixture:)];
    editFixture.style = UIBarButtonItemStyleBordered;
    UIBarButtonItem* editClub = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editClub:)];
     
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 15;
    UIBarButtonItem *fixedSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 15;
    
    if ([self.navigationItem respondsToSelector:@selector(rightBarButtonItems)])
    {
        self.navigationItem.rightBarButtonItems = [[NSMutableArray alloc] initWithObjects:editPlayers, editFixture, editClub, nil];
    }
    else
    {
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 130.0f, 44.01f)]; // 44.01 shifts it up 1px for some reason
       // toolBar.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f]; // closest I could get by eye to black, translucent style.
        //toolBar.barStyle = -1; // clear background
        toolBar.backgroundColor = [UIColor clearColor];
    
        [toolBar setItems:[[NSMutableArray alloc] initWithObjects:editFixture, fixedSpace, editPlayers, fixedSpace2, editClub, nil] animated:NO];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolBar];
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
    NSLog(@"In view did load: %@", [[[self session] selectedClub] name]);
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationItem.hidesBackButton = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    int rows = 0;
    if ([[self session] selectedClub] != nil)
    {
        rows = [[[[self session] selectedClub] combinedClubFixture] count];
    }
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.00;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FixtureMatchCell";
    
    FixtureMatchViewController* matchViewController = nil;
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        NSLog(@"height: %f width: %f", cell.contentView.bounds.size.height, cell.contentView.bounds.size.width);
        
        matchViewController = [[FixtureMatchViewController alloc] initWithNibName:@"FixtureMatchViewController" bundle:nil]; 
        [cell.contentView addSubview:matchViewController.view];
    }
    CGRect viewFrame = CGRectMake(0.0, 0.0, tableView.bounds.size.width, 100);
    matchViewController.view.frame = viewFrame;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    UIView* subview = [cell.contentView.subviews objectAtIndex:0];
    matchViewController = (FixtureMatchViewController*) [subview nextResponder];
    
    Match* match = [[[[self session] selectedClub] combinedClubFixture] objectAtIndex:indexPath.row];
    matchViewController.match = match;
    matchViewController.club = [[self session] selectedClub];
    
    [matchViewController reloadData];
    
    //MultiColumnTableCell *cell = (MultiColumnTableCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    //    cell = [[[MultiColumnTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    //}
    
    //[cell initialize];
        
    
    
    // Don't uncomment CGRectMake(x, y, width, height)
    
    //int margin = 10;
    //int col1start=0.0;
    //int col1width=90;
    //int col1end=col1start+col1width+margin;
    //[cell addColumnWithStart:col1start withWidth:col1width withEnd:col1end withText:label1 withHeight:tableView.rowHeight];
        
    //int col2start=col1end+margin;
    //int col2width=220;
    //int col2end=col2start+col2width+margin;
    //[cell addColumnWithStart:col2start withWidth:col2width withEnd:col2end withText:label2 withHeight:tableView.rowHeight];
        
    //int col3start=col2end+margin;
    //int col3width=220;
    //int col3end=col3start+col3width+margin;
    //[cell addColumnWithStart:col3start withWidth:col3width withEnd:col3end withText:label3 withHeight:tableView.rowHeight];
    
    
    //cell.textLabel.text = [NSString stringWithFormat:@"Fixture Game One for %@", self.selectedClub.name];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    Match* match = [[[[self session] selectedClub] combinedClubFixture] objectAtIndex:indexPath.row];
    [self session].selectedMatch = match;
    NSLog(@"selected match date: %@", [[match date] description]);
    
    GameDayStatsViewController* statsView = [[GameDayStatsViewController alloc] initWithNibName:@"GameDayStatsViewController" bundle:nil];
    //SelectTeamViewController* selectTeamView = [[SelectTeamViewController alloc] initWithNibName:@"SelectTeamViewController" bundle:nil];
    
    UINavigationController* modalNavBar = [[self appDelegate] modalNavBar];
    [[[[self appDelegate] window] rootViewController] presentModalViewController:modalNavBar animated:YES];
    
    //[modalNavBar pushViewController:selectTeamView animated:YES];
    [modalNavBar pushViewController:statsView animated:YES];
    
    //[[[[self appDelegate] window] rootViewController] pushViewController:selectTeamView animated:YES];
    //[self.navigationController pushViewController:selectTeamView animated:YES];
    

    
    //[self.navBar pushViewController:selectTeamView animated:YES];
    //[selectTeamView release];
    [statsView release];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Club Fixture";
    }
    else
    {
        return @"";
    }
}

#pragma mark - UISplitViewControllerDelegate methods

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    
    NSLog(@"show button");
    barButtonItem.title = @"Clubs";
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.popOver = pc;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSLog(@"hide button");
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.popOver = nil;
}

- (IBAction)editPlayers:(id)sender
{
    UINavigationController* modalNavBar = [[UINavigationController alloc] init];
    
    ListPlayersViewController* listPlayersView = [[ListPlayersViewController alloc] initWithStyle:UITableViewStylePlain];
    [[[[self appDelegate] window] rootViewController] presentModalViewController:modalNavBar animated:YES];
    [modalNavBar pushViewController:listPlayersView animated:YES];
    [listPlayersView release];
    [modalNavBar release];
}

- (IBAction)editFixture:(id)sender
{
    //UINavigationController* modalNavBar = [[UINavigationController alloc] init];
    
    EditFixtureViewController* editFixtureView = [[EditFixtureViewController alloc] initWithNibName:@"EditFixtureViewController" bundle:nil];
    //[[[[self appDelegate] window] rootViewController] presentModalViewController:editFixtureView animated:YES];
    //[modalNavBar pushViewController:editFixtureView animated:YES];
    [self.navigationController pushViewController:editFixtureView animated:YES];
    [editFixtureView release];
    //[modalNavBar release];
}

- (IBAction)editClub:(id)sender
{
    UINavigationController* modalNavBar = [[UINavigationController alloc] init];
    
    EditClubViewController* editClubViewController = [[EditClubViewController alloc] initWithNibName:@"EditClubViewController" bundle:nil];
    editClubViewController.club = [[self session] selectedClub];
    
    [self.navigationController presentModalViewController:modalNavBar animated:YES];
    //[[[[self appDelegate] window] rootViewController] presentModalViewController:modalNavBar animated:YES];
    [modalNavBar pushViewController:editClubViewController animated:YES];
    [editClubViewController release];
    [modalNavBar release];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *CellIdentifier = @"MultiColumnCell";
    
//    MultiColumnTableCell* cell = [[[MultiColumnTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
//    [cell initialize];
//    cell.backgroundColor = [UIColor lightGrayColor];
    
//    int margin = 10;
//    int col1start=0.0;
//    int col1width=90;
//    int col1end=col1start+col1width+margin;
//    [cell addColumnWithStart:col1start withWidth:col1width withEnd:col1end withText:@"Date" withHeight:tableView.rowHeight];
    
//    int col2start=col1end+margin;
//    int col2width=220;
//    int col2end=col2start+col2width+margin;
//    [cell addColumnWithStart:col2start withWidth:col2width withEnd:col2end withText:@"Home Team" withHeight:tableView.rowHeight];
    
//    int col3start=col2end+margin;
//    int col3width=220;
//    int col3end=col3start+col3width+margin;
//    [cell addColumnWithStart:col3start withWidth:col3width withEnd:col3end withText:@"Away Team" withHeight:tableView.rowHeight];

//    if (section == 0)
//    {
//        return cell;
//    }
//    else
//    {
//        return nil;
//    }
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        return tableView.rowHeight;
//    }
//    else
//    {
//        return 0.0;
//    }
//}


@end
