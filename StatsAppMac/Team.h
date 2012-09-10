//
//  Team.h
//  StatsAppMac
//
//  Created by David Mackenzie on 7/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Club;

@interface Team : NSManagedObject {
@private
}
@property (nonatomic, retain) Club * club;

@end
