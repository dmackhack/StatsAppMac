//
//  ListClubsTableViewConroller.m
//  StatsAppMac
//
//  Created by David Mackenzie on 15/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ListClubsTableViewConroller.h"


@implementation ListClubsTableViewConroller


@synthesize cache=cache_, searchBar=searchBar_, listPlayersView=listPlayersView_, searchTerm=searchTerm_, fixtureSearchDelegate=fixtureSearchDelegate_;

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
    [cache_ release];
    [listPlayersView_ release];
    [searchBar_ release];
    [searchTerm_ release];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        return YES;
    }
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* msg = [NSString stringWithFormat:@"Search Clicked: %@", [searchBar text]];
    NSLog(msg);
    self.searchTerm = self.searchBar.text;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"Cancel");
    self.searchTerm = nil;
    [self session].selectedClub = nil;
    //[self.fixtureSearchDelegate updateFixture];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Text changed: [%@]", searchText);
    if (searchText != nil && [searchText length] > 0)
    {        
        self.searchTerm = searchText;
        NSLog(@"Setting search term [%@]", self.searchTerm);
    }
    else
    {
        self.searchTerm = @"";
    }    
    
    [self.tableView reloadData];
}

- (NSFetchedResultsController *) resultsController
{
    
    
    StatsAppMacAppDelegate* appDel = self.appDelegate;
    SqlLiteRepository* repo = [appDel repo];
    
    NSManagedObjectContext* context = [repo managedObjectContext];
    NSFetchRequest* fetchClubsByName = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* playerEntityDescription = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:context];
    [fetchClubsByName setEntity:playerEntityDescription];
    
    //NSString* searchTerm = nil;
    NSLog(@"Search Term: %@", self.searchTerm);
    if (self.searchTerm != nil)
    {    
        NSLog(@"Appending Predicate");
        NSPredicate* clubsByNamePredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", self.searchTerm];
        [fetchClubsByName setPredicate:clubsByNamePredicate];
    }
    
    NSSortDescriptor* clubsByNameSD = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchClubsByName setSortDescriptors:[NSArray arrayWithObject:clubsByNameSD]];
    
    resultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchClubsByName managedObjectContext:context sectionNameKeyPath:nil cacheName:[self cache]];
    
    resultsController_.delegate = self;
    
    NSError* error;
    BOOL success = [resultsController_ performFetch:&error];
    
    if (!success)
    {
        NSLog(@"Error fetching results");
    }
    [fetchClubsByName release];
    return resultsController_;
    
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
    
    NSLog(@"In number of rows %i", [self.resultsController.fetchedObjects count]);
    return [self.resultsController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    
    Club* club = [self.resultsController.fetchedObjects objectAtIndex:indexPath.row];
    
    NSLog(@"Club Name: %@", club.name);
    cell.textLabel.text = [NSString stringWithFormat:club.name];
    
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
    
    Club* club = [self.resultsController.fetchedObjects objectAtIndex:indexPath.row];
    NSLog(@"Selected Club For Edit: %@", club.name);
    
    [self session].selectedClubForEdit = club;
    [self session].selectedClub = club;
    if (self.listPlayersView != nil)
    {
        [self.listPlayersView.tableView reloadData];
    }
    if (self.fixtureSearchDelegate != nil)
    {
        [self.fixtureSearchDelegate updateFixture];
    }
    
    StatsAppMacNotificationCentre* noticicationCentre = [[self appDelegate] notificationCentre];
    [noticicationCentre onChange];
    
}

@end
