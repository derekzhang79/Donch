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
}

- (IBAction)clearAllRecord:(UIButton *)sender
{
    DonchManager *donchManager = [DonchManager getInstance];
    [donchManager clearYogaStatus];
}

- (IBAction)switchClicked:(UIButton *)sender
{
    UIImage *switchImageGreen = [UIImage imageNamed: @"switchUI_1"];
    UIImage *switchImageRed = [UIImage imageNamed: @"switchUI_2"];
    if (sender.tag == 0){
        sender.tag = 1;
        [sender setImage:switchImageRed forState:UIControlStateNormal];
    } else {
        sender.tag = 0;
        [sender setImage:switchImageGreen forState:UIControlStateNormal];
    }
    
}

@end
