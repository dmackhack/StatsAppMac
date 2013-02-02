//
//  StatsAppMacNotificationCentre.h
//  StatsAppMac
//
//  Created by David Mackenzie on 2/02/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectedClubForEditChangedListener.h"



@interface StatsAppMacNotificationCentre : NSObject <SelectedClubForEditChangedListener> {
    NSMutableArray* selectedClubForEditChangedListeners_;
}

@property (nonatomic, retain) NSMutableArray* selectedClubForEditChangedListeners;


- (void) addSelectClubForEditChangeListener:(id<SelectedClubForEditChangedListener>) listener;
- (void) removeSelectClubForEditChangeListener:(id<SelectedClubForEditChangedListener>) listener;

@end
