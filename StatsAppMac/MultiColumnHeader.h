//
//  MultiColumnHeader.h
//  StatsAppMac
//
//  Created by David Mackenzie on 4/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultiColumnHeader : UIView {
    NSMutableArray* columnSizes_;
    NSMutableArray* columnValues_;
}

@property (nonatomic, retain) NSMutableArray* columnSizes;
@property (nonatomic, retain) NSMutableArray* columnValues;

- (void) addColumn:(int) end withText:(NSString*) text;
- (void) initialize;

@end
