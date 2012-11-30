//
//  SettingsViewController.h
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *settingsSwitch0;
@property (weak, nonatomic) IBOutlet UIButton *settingsSwitch1;
@property (weak, nonatomic) IBOutlet UIButton *settingsSwitch2;
@property (weak, nonatomic) IBOutlet UIButton *settingsSwitch3;
@property (weak, nonatomic) IBOutlet UIButton *settingsSwitch4;

- (IBAction)clearAllRecord:(UIButton *)sender;


@end
