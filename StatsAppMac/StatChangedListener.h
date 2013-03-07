//
//  StatChangedListener.h
//  StatsAppMac
//
//  Created by David Mackenzie on 8/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol StatChangedListener <NSObject>

- (void) onStatChanged;

@end
