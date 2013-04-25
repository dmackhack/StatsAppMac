//
//  EditClubViewController.m
//  StatsAppMac
//
//  Created by David Mackenzie on 25/04/13.
//
//

#import "EditClubViewController.h"

@interface EditClubViewController ()

@end

@implementation EditClubViewController

@synthesize club=club_,clubDetailsView=clubDetailsView_, teamsTableView=teamsTableView_, nameTextField=nameTextField_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [club_ release];
    [clubDetailsView_ release];
    [teamsTableView_ release];
    [nameTextField_ release];
    [super dealloc];
}

@end
