//
//  SettingsViewController.m
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import "SettingsViewController.h"
#import "DonchManager.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)clearAllRecord:(UIButton *)sender
{
    DonchManager *donchManager = [DonchManager getInstance];
    [donchManager clearYogaStatus];
}

- (void) changeSwitch
{
    
}

@end
