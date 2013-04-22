//
//  RoundPickerViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 8/04/13.
//
//

#import <UIKit/UIKit.h>
#import "FixtureSqlLiteRepository.h"
#import "League.h"
#import "Division.h"
#import "Season.h"
#import "Round.h"

@class StatsAppMacAppDelegate;

@interface RoundPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    Match* match_;
    UIPickerView* roundPicker_;
    Round* selectedRound_;
}

@property (nonatomic, retain) Match* match;
@property (nonatomic, retain) Round* selectedRound;
@property (nonatomic, retain) IBOutlet UIPickerView* roundPicker;

- (id)initWithMatch:(Match*)match andPicker:(UIPickerView*)pickerView;

@end
