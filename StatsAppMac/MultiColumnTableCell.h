//
//  MultiColumnTableCell.h
//  StatsAppMac
//
//  Created by David Mackenzie on 11/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MultiColumnTableCell : UITableViewCell {
    NSMutableArray* columns_;
}

@property (nonatomic, retain) NSMutableArray* columns;

- (void) addColumnWithStart:(int)start withWidth:(int)width withEnd:(int)end withText:(NSString*)text withHeight:(int)height;
- (void) initialize;




@end
