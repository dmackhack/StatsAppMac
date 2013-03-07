//
//  StatChangedEvent.h
//  StatsAppMac
//
//  Created by David Mackenzie on 8/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatChangedListener.h"

@protocol StatChangedEvent <NSObject>

- (void) onStatChangedPerformed;

//- (void) addStatChangeListener:(<id>StatChangedListener*) listener;
//- (void) removeStatChangeListener:(<id>StatChangedListener*) listener;

@end
