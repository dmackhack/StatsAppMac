//
//  Team.h
//  StatsAppMac
//
//  Created by David Mackenzie on 15/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Club, TeamParticipant;

@interface Team : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Club * club;
@property (nonatomic, retain) NSSet* teamParticipants;

@end
