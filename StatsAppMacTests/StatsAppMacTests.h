//
//  StatsAppMacTests.h
//  StatsAppMacTests
//
//  Created by David Mackenzie on 25/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <CoreData/CoreData.h>
#import "SqlLiteRepository.h"
#import "Club.h"
#import "CClub.h"




@interface StatsAppMacTests : SenTestCase {
@private
    
    SqlLiteRepository* _repo;
    
}

@property(nonatomic, retain) SqlLiteRepository* repo;

@end
