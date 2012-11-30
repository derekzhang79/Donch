//
//  SettingsViewController.h
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *switch01;

- (IBAction)clearAllRecord:(UIButton *)sender;
- (IBAction)switchClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *testswitch;

@end
