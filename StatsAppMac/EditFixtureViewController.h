//
//  EditFixtureViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 15/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlLiteRepository.h"
#import "ClubSqlLiteRepository.h"
#import "Round.h"
#import "RoundPickerViewController.h"

@class StatsAppMacAppDelegate;

@interface EditFixtureViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverControllerDelegate> {
    
    Match* match_;
    
    UITextField* roundTextField_;
    UIDatePicker* datePicker_;
    UIPickerView* homeTeamPicker_;
    UIPickerView* awayTeamPicker_;
    //UIPickerView* roundPicker_;
    UILabel* roundLabel_;
    UIButton* editRoundButton_;
    
    UILabel* dateLabel_;
    UIButton* editDateButton_;
    
    UILabel* homeTeamLabel_;
    UIButton* editHomeTeamButton_;
    
    UILabel* awayTeamLabel_;
    UIButton* editAwayTeamButton_;
    
    UILabel* divisionLabel_;
    
    UIPopoverController* popOver_;
    
    
    RoundPickerViewController* roundPickerController_;
}

@property (nonatomic, retain) Match* match;

@property (nonatomic, retain) IBOutlet UITextField* roundTextField;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet UIPickerView* homeTeamPicker;
@property (nonatomic, retain) IBOutlet UIPickerView* awayTeamPicker;
//@property (nonatomic, retain) IBOutlet UIPickerView* roundPicker;
@property (nonatomic, retain) IBOutlet RoundPickerViewController* roundPickerController;
@property (nonatomic, retain) IBOutlet UIPopoverController* popOver;
@property (nonatomic, retain) IBOutlet UILabel* roundLabel;
@property (nonatomic, retain) IBOutlet UIButton* editRoundButton;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UIButton* editDateButton;
@property (nonatomic, retain) IBOutlet UILabel* homeTeamLabel;
@property (nonatomic, retain) IBOutlet UIButton* editHomeTeamButton;
@property (nonatomic, retain) IBOutlet UILabel* awayTeamLabel;
@property (nonatomic, retain) IBOutlet UIButton* editAwayTeamButton;
@property (nonatomic, retain) IBOutlet UILabel* divisionLabel;



- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction) editRoundClicked:(id)sender;
- (IBAction) editDateClicked:(id)sender;
- (IBAction) editHomeTeamClicked:(id)sender;
- (IBAction) editAwayTeamClicked:(id)sender;

@end
