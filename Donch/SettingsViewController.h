//
//  SettingsViewController.h
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

- (IBAction)clearAllRecord: (UIButton *)sender;
- (IBAction)switchClicked: (UIButton *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *testswitch;

@end
