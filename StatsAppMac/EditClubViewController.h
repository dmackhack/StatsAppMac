//
//  EditClubViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 25/04/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Club.h"
#import "CClub.h"
#import "Team.h"
#import "SqlLiteRepository.h"

@class StatsAppMacAppDelegate;

@interface EditClubViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    Club* club_;
    
    UIView* clubDetailsView_;
    UITableView* teamsTableView_;
    UITextField* clubNameTextField_;
    UITextField* teamNameTextField_;
    UIBarButtonItem* addTeamButton_;
}

@property (nonatomic, retain) Club* club;

@property (nonatomic, retain) IBOutlet UIView* clubDetailsView;
@property (nonatomic, retain) IBOutlet UITableView* teamsTableView;
@property (nonatomic, retain) IBOutlet UITextField* clubNameTextField;
@property (nonatomic, retain) IBOutlet UITextField* teamNameTextField;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* addTeamButton;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)addTeam:(id)sender;


@end
