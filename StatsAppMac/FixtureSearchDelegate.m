//
//  FixtureSearchDelegate.m
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FixtureSearchDelegate.h"


@implementation FixtureSearchDelegate

@synthesize selectedClub=selectedClub_;

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
    [selectedClub_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) updateFixture: (Club*) selectedClub;
{
    self.selectedClub = selectedClub;
    [self.tableView reloadData];
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    if (self.selectedClub != nil)
    {
        rows = [self.selectedClub.teams count];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultiColumnCell";
    
    MultiColumnTableCell *cell = (MultiColumnTableCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MultiColumnTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        [cell initialize];
        
        Team* team = [[self.selectedClub.teams allObjects] objectAtIndex:indexPath.row];
        
        // CGRectMake(x, y, width, height)
        UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0, 80.0, tableView.rowHeight)] autorelease];
        [cell addColumn:100];
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = [NSString stringWithFormat:@"%@", team.name];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = [UIColor blueColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:label];
        
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(110.0, 0, 80.0, tableView.rowHeight)] autorelease];
        [cell addColumn:200];
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = [NSString stringWithFormat:@"%@", team.club.name];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = [UIColor blueColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:label];
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(210.0, 0, 120.0, tableView.rowHeight)] autorelease];
        [cell addColumn:350];
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = [NSString stringWithFormat:@"%@", @"Third Column"];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = [UIColor blueColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:label];
    }
    
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
    
    Team* team = [[self.selectedClub.teams allObjects] objectAtIndex:indexPath.row];
    NSLog(@"selected team: %@", [team name]);
}

@end
