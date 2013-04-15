//
//  FootyStatsTests.h
//  FootyStatsTests
//
//  Created by David Mackenzie on 16/04/13.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "Round.h"
#import "SqlLiteRepository.h"

@interface FootyStatsTests : SenTestCase {
@private
    
    SqlLiteRepository* repo_;
    
}

@property(nonatomic, retain) SqlLiteRepository* repo;

@end
