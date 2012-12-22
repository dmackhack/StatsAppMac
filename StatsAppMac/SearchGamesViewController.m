//
//  SearchGamesViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 4/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchGamesViewController.h"


@implementation SearchGamesViewController

NSString* searchTerm;

@synthesize tableView=tableView_, searchBar=searchBar_, resultsController=resultsController_, cache=cache_, fixturesTableView=fixturesTableView_, fixtureSearchDelegate=fixtureSearchDelegate_;

- (StatsAppMacAppDelegate *) appDelegate
{
    return (StatsAppMacAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    FixtureSearchDelegate* fixtureSearchDelegate = [[FixtureSearchDelegate alloc] init];
    
    self.fixtureSearchDelegate = fixtureSearchDelegate;
    self.fixturesTableView.delegate = fixtureSearchDelegate;
    self.fixturesTableView.dataSource = fixtureSearchDelegate;
    self.fixtureSearchDelegate.tableView = self.fixturesTableView;
    
    [fixtureSearchDelegate release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* msg = [NSString stringWithFormat:@"Search Clicked: %@", [searchBar text]];
    NSLog(msg);
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"Cancel");
    searchTerm = nil;
    [self session].selectedClub = nil;
    [self.fixtureSearchDelegate updateFixture];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // NSLog(searchText);
    searchTerm = searchText;
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

    NSLog(@"Search Term: %@", searchTerm);
    if (searchTerm != nil)
    {    
        NSPredicate* clubsByNamePredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchTerm];
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
    return [self.resultsController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] init];
    }
    Club* club = [self.resultsController.fetchedObjects objectAtIndex:indexPath.row];
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
    
    [self session].selectedClub = [self.resultsController.fetchedObjects objectAtIndex:indexPath.row];
    [self.fixtureSearchDelegate updateFixture];
    
    NSLog(@"Selected Club: %@", [[self session] selectedClub].name);
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Club Search Results";
    }
    else
    {
        return @"";
    }
}


@end
