//
//  EditPlayerViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 25/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface EditPlayerViewController : UIViewController {
    
    Player* player_;
    
    UITextField* firstNameTextView_;
    UITextField* lastNameTextView_;
    UITextField* numberTextView_;
    
    
}

@property (nonatomic, retain) Player* player;

@property (nonatomic, retain) IBOutlet UITextField* firstNameTextView;
@property (nonatomic, retain) IBOutlet UITextField* lastNameTextView;
@property (nonatomic, retain) IBOutlet UITextField* numberTextView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
