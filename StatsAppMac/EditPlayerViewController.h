//
//  EditPlayerViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 25/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Player.h"
#import "Club.h"
#import "CClub.h"
#import "SqlLiteRepository.h"
#import "StatsAppMacSession.h"

@class StatsAppMacAppDelegate;


@interface EditPlayerViewController : UIViewController {
    
    Player* player_;
    
    UITextField* userIdTextView_;
    UITextField* firstNameTextView_;
    UITextField* lastNameTextView_;
    UITextField* numberTextView_;
    UITextField* activeTextView_;
    UISwitch* activeSwitch_;
    
    UIView* backgroundView_;
    UIView* playerDetailsView_;
    
    
}

@property (nonatomic, retain) Player* player;

@property (nonatomic, retain) IBOutlet UITextField* userIdTextView;
@property (nonatomic, retain) IBOutlet UITextField* firstNameTextView;
@property (nonatomic, retain) IBOutlet UITextField* lastNameTextView;
@property (nonatomic, retain) IBOutlet UITextField* numberTextView;
@property (nonatomic, retain) IBOutlet UITextField* activeTextView;
@property (nonatomic, retain) IBOutlet UISwitch* activeSwitch;

@property (nonatomic, retain) IBOutlet UIView* backgroundView;
@property (nonatomic, retain) IBOutlet UIView* playerDetailsView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
