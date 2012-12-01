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
    BOOL doingExercise;
    DCCustomAlert *customAlert;
}
@end

@implementation ExerciseViewController
@synthesize currentYogaIndex, exerciseImage, countImageView, countDownLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prepareExercise)];
    [exerciseImage addGestureRecognizer:tap];
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(switchLeft)];
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(switchRight)];

    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [exerciseImage addGestureRecognizer:swipeGestureLeft];
    [exerciseImage addGestureRecognizer:swipeGestureRight];
    currentYogaIndex = 0;

    
}
- (void)viewWillAppear:(BOOL)animated {
    Yoga *currentYoga = [self getYogaWithIndex:currentYogaIndex];
    exerciseImage.image = [UIImage imageNamed:currentYoga.imageName];

}
- (void) switchLeft {
    currentYogaIndex++;
    Yoga *currentYoga = [self getYogaWithIndex:currentYogaIndex];
    if (currentYoga != nil)
        exerciseImage.image = [UIImage imageNamed:currentYoga.imageName];
}
- (void) switchRight {
    currentYogaIndex--;
    Yoga *currentYoga = [self getYogaWithIndex:currentYogaIndex];
    if (currentYoga != nil)
        exerciseImage.image = [UIImage imageNamed:currentYoga.imageName];
}
- (void) prepareExercise {
    if (doingExercise == true)
        return;
    customAlert = [[DCCustomAlert alloc] initWIthMessageImage:[UIImage imageNamed:@"Are_you_ready"]
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
    doingExercise = true;
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
        doingExercise = false;
        [timer invalidate];
        customAlert = [[DCCustomAlert alloc] initWIthMessageImage:[UIImage imageNamed:@"Is_this_ok"]
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
        DonchManager *mgr = [DonchManager getInstance];
        [mgr updateYogaStatusWithIndex:currentYogaIndex];
        NSArray *arrayList = [mgr listAllYoga];
        UIImageView *lastModel = [[UIImageView alloc] initWithImage:exerciseImage.image];
        currentYogaIndex = currentYogaIndex == ([arrayList count] - 1) ? currentYogaIndex : currentYogaIndex + 1;
        Yoga *currentYoga = [self getYogaWithIndex: currentYogaIndex];
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
    if (index < 0 || index == [yogalist count]){
        return nil;
    } else {
        return [yogalist objectAtIndex:index] ;
    }
}
@end
