//
//  Round.h
//  StatsAppMac
//
//  Created by David Mackenzie on 17/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Match, Season;

@interface Round : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Season * season;
@property (nonatomic, retain) NSSet* matches;

@end
