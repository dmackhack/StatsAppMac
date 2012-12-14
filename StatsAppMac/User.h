//
//  User.h
//  StatsAppMac
//
//  Created by David Mackenzie on 14/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ParticipantStatistics;

@interface User : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSSet* participantStatistics;

@end
