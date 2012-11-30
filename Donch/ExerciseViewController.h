//
//  ExerciseViewController.h
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import <UIKit/UIKit.h>
#import "DCCustomAlert.h"

@interface ExerciseViewController : UIViewController<DCCustomAlertDelegate>

@property int currentYogaIndex;
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImage;
@property (weak, nonatomic) IBOutlet UIImageView *countImageView;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@end
