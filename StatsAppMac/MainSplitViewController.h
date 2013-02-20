//
//  MainSplitViewController.h
//  StatsAppMac
//
//  Created by David Mackenzie on 18/02/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainSplitViewController : UISplitViewController <UISplitViewControllerDelegate> {

    UIWindow* window_;
    UISplitViewController* splitViewContoller_;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UISplitViewController* splitViewContoller;

@end
