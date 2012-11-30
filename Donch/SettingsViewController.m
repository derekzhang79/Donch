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
    UIImage *switchImageGreen = [UIImage imageNamed:@"switchUI_1"];
    self.testswitch.onImage = switchImageGreen;
    [self.testswitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    
    [self.switch01 setBackgroundImage:switchImageGreen forState:UIControlStateNormal];
    
}      

- (IBAction)clearAllRecord:(UIButton *)sender
{
    DonchManager *donchManager = [DonchManager getInstance];
    [donchManager clearYogaStatus];
}

- (IBAction)switchClicked:(UIButton *)sender
{
    UIImage *switchImageGreen = [UIImage imageNamed:@"switchUI_1"];
    UIImage *switchImageRed = [UIImage imageNamed:@"switchUI_2"];
    
    if([@"switchUI_1" isEqual:self.switch01.currentImage]){
        [sender setImage:switchImageRed forState:UIControlStateNormal];
    }else{
        [sender setImage:switchImageGreen forState:UIControlStateNormal];

    }
}

- (void)switchToggled:(id)sender
{
    UIImage *switchImageGreen = [UIImage imageNamed:@"switchUI_1"];
    UIImage *switchImageRed = [UIImage imageNamed:@"switchUI_2"];
    
	if(self.testswitch.on=YES){
        [self.testswitch setOffImage:switchImageRed];
        [self.testswitch setOn:NO animated:YES];
    }else if (self.testswitch.on=NO){
        [self.testswitch setOffImage:switchImageGreen];
        [self.testswitch setOn:YES animated:YES];
    }
}


@end
