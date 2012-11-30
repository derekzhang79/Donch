//
//  GoalViewController.h
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import <UIKit/UIKit.h>

@interface GoalViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;

- (IBAction)selectExercise:(UIButton *)sender;

@end
