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

- (void) addColumn:(CGFloat) position;
- (void) initialize;

@end
