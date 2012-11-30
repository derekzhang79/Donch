//
//  ExerciseViewController.m
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import "ExerciseViewController.h"
#import "Yoga.h"
@interface ExerciseViewController () {
    int counter;
}
@end

@implementation ExerciseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DCCustomAlert *customAlert = [[DCCustomAlert alloc] initWIthMessageImage:[UIImage imageNamed:@"Are_you_ready@2x"]
                                                                    delegate:self
                                                             okayButtonImage:[UIImage imageNamed:@"start"]
                                                           cancelButtonTitle:nil];
    [self.view addSubview:customAlert];
    [customAlert show];
}

- (void) startExcerise: (Yoga *) yoga {
    counter = [yoga.minutes doubleValue] * 60;
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
//    [countdownField setIntegerValue:counter];
    NSString *counterText = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    NSLog(counterText);
    if (counter <= 0) {
        [timer invalidate];
        //Exercise finished
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark DCCustomAlertDelegate
- (void)alertView:(DCCustomAlert *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self startExcerise:nil];
}
@end
