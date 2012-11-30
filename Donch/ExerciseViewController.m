//
//  ExerciseViewController.m
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import "ExerciseViewController.h"
#import "DonchManager.h"
#import "Yoga.h"
@interface ExerciseViewController () {
    int counter;
}
@end

@implementation ExerciseViewController
@synthesize currentYogaIndex, exerciseImage, countImageView, countDownLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentYogaIndex = 0;
    Yoga *currentYoga = [self getYogaWithIndex:currentYogaIndex];
    exerciseImage.image = [UIImage imageNamed:currentYoga.imageName];
    [self prepareExercise];
}
- (void) prepareExercise {
    DCCustomAlert *customAlert = [[DCCustomAlert alloc] initWIthMessageImage:[UIImage imageNamed:@"Are_you_ready"]
                                                                    delegate:self
                                                             okayButtonImage:[UIImage imageNamed:@"btn_start"]
                                                           cancelButtonTitle:nil];
    customAlert.alertTag = @"startAlert";
    [self.view addSubview:customAlert];
    [customAlert show];
}
- (void) startExcerise: (Yoga *) yoga {
    counter = [yoga.minutes doubleValue] * 60;
    counter = 3;
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(countDownTimer:)
                                   userInfo:nil
                                    repeats:YES];
    
}
- (void)countDownTimer:(NSTimer *)timer
{
    int seconds = counter % 60;
    int minutes = (counter / 60) % 60;
    counter -= 1;
    NSString *counterText = [NSString stringWithFormat:@"%02d:%02d\"", minutes, seconds];
    countDownLabel.text = counterText;
    if (counter < 0) {
        [timer invalidate];
        DCCustomAlert *customAlert = [[DCCustomAlert alloc] initWIthMessageImage:[UIImage imageNamed:@"Is_this_ok"]
                                                                        delegate:self
                                                                 okayButtonImage:[UIImage imageNamed: @"btn_ok"]
                                                               cancelButtonTitle:[UIImage imageNamed: @"btn_hard"]];
        customAlert.alertTag = @"continueAlert";
        [self.view addSubview:customAlert];
        [customAlert show];
    }
}


#pragma mark -
#pragma mark DCCustomAlertDelegate
- (void)alertView:(DCCustomAlert *)alertView willDismissWithButtonIndex:(NSInteger) buttonIndex {
    NSString *tag = [alertView alertTag];
    if ([tag isEqualToString:@"startAlert"]) {
        [self startExcerise: [self getYogaWithIndex:currentYogaIndex]];
    } else if ([tag isEqualToString:@"continueAlert"] && buttonIndex == 1) { // Press OK
        UIImageView *lastModel = [[UIImageView alloc] initWithImage:exerciseImage.image];
        currentYogaIndex = currentYogaIndex + 1;
        Yoga *currentYoga = [self getYogaWithIndex:currentYogaIndex];
        if (currentYoga == nil)
            return;
        exerciseImage.image = [UIImage imageNamed:currentYoga.imageName];
        
        lastModel.center = exerciseImage.center;
        [self.view insertSubview: lastModel belowSubview: countImageView];
        [UIView transitionFromView:lastModel toView:exerciseImage duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
            if (finished) {
                [lastModel removeFromSuperview];
                [self.view bringSubviewToFront:countImageView];
                [self.view bringSubviewToFront:countDownLabel];
                [self prepareExercise];
            }
        }];
    }
}
- (Yoga *) getYogaWithIndex: (int) index {
    NSArray *yogalist = [[DonchManager getInstance] listAllYoga];
    if (index == [yogalist count]){
        return nil;
    } else {
        return [yogalist objectAtIndex:index] ;
    }
}
@end
