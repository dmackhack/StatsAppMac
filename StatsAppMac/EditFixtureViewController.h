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

@interface EditFixtureViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    Match* match_;
    
    UITextField* roundTextField_;
    UIDatePicker* datePicker_;
    UIPickerView* homeTeamPicker_;
    UIPickerView* awayTeamPicker_;
    UIPickerView* roundPicker_;
    
    RoundPickerViewController* roundPickerController_;
}

@property (nonatomic, retain) Match* match;

@property (nonatomic, retain) IBOutlet UITextField* roundTextField;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet UIPickerView* homeTeamPicker;
@property (nonatomic, retain) IBOutlet UIPickerView* awayTeamPicker;
@property (nonatomic, retain) IBOutlet UIPickerView* roundPicker;
@property (nonatomic, retain) IBOutlet RoundPickerViewController* roundPickerController;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
