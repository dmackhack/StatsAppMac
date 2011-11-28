//
//  StatsCell.h
//  StatsAppMac
//
//  Created by David MacKenzie on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@class Player;

@interface StatsCell : UITableViewCell
{
    Player* player_;
    UILabel* playerName_;
}

@property (nonatomic, retain) Player* player;
@property (nonatomic, retain) IBOutlet UILabel* playerName;

- (IBAction)addKick:(id)sender;
- (IBAction)addMark:(id)sender;
- (IBAction)addHandball:(id)sender;
- (IBAction)addTackle:(id)sender;


@end
