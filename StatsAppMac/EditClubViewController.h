//
//  EditClubViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 25/04/13.
//
//

#import <UIKit/UIKit.h>
#import "Club.h"
#import "Team.h"

@interface EditClubViewController : UIViewController {
    
    Club* club_;
    
    UIView* clubDetailsView_;
    UITableView* teamsTableView_;
    UITextField* nameTextField_;
}

@property (nonatomic, retain) Club* club;

@property (nonatomic, retain) IBOutlet UIView* clubDetailsView;
@property (nonatomic, retain) IBOutlet UITableView* teamsTableView;
@property (nonatomic, retain) IBOutlet UITextField* nameTextField;

@end
