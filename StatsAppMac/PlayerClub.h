//
//  PlayerClub.h
//  StatsAppMac
//
//  Created by David Mackenzie on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Club, Player;

@interface PlayerClub : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) Club * club;
@property (nonatomic, retain) Player * player;

@end
