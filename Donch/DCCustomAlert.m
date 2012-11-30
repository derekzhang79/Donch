//
//  DCCustomAlert.m
//  Donch
//
//  Created by Ryan on 11/30/12.
//
//

#import "DCCustomAlert.h"

@implementation DCCustomAlert
@synthesize isShown, alertView, delegate, alertTag;

typedef enum {
    OK,
    CANCEL
} AlertButtonType;

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.alpha = 0;
    alertView.userInteractionEnabled = YES;
}


- (id)initWIthMessageImage:(UIImage *) messageImage
                  delegate:(id <DCCustomAlertDelegate>) alertDelegate
           okayButtonImage:(UIImage *) okayButtonImage
         cancelButtonTitle:(UIImage *) cancelButtonImage {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:frame];
    self.delegate = alertDelegate;
    
    UIImage *alertBackgroundImage = [UIImage imageNamed:@"dia_bg"];
    alertView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2 - alertBackgroundImage.size.width/2,
                                                              frame.size.height/2 - alertBackgroundImage.size.height/2,
                                                              alertBackgroundImage.size.width,
                                                              alertBackgroundImage.size.height)];
    alertView.image = alertBackgroundImage;
    
//    [alertView addSubview:[self getTitleLabel:title]];
    UIImageView *messageView = [[UIImageView alloc] initWithImage:messageImage];
    messageView.center = CGPointMake(alertView.center.x, 50);
    [alertView addSubview: messageView];
    
    BOOL singleButton = (cancelButtonImage == nil & okayButtonImage != nil);
    BOOL noButton = (okayButtonImage == nil & cancelButtonImage ==nil);
    
    UIButton *okButton = [self getRightButton:@"開始"];
    [okButton setBackgroundImage:okayButtonImage forState:UIControlStateNormal];

    if (singleButton) {
        [okButton setFrame:CGRectMake(alertView.frame.size.width/2 - okayButtonImage.size.width/2,
                                      alertView.frame.size.height - okayButtonImage.size.height - 30,
                                      okayButtonImage.size.width,
                                      okayButtonImage.size.height)];
        [alertView insertSubview:okButton atIndex:0];
    }else if (noButton){
        // do nothing i think -elisha
    }else {
        UIButton *hardButton = [self getLeftButton:nil];
        [hardButton setFrame:CGRectMake(alertView.frame.size.width / 2 - 30 - cancelButtonImage.size.width,
                                          alertView.frame.size.height - cancelButtonImage.size.height - 30,
                                          cancelButtonImage.size.width,
                                          cancelButtonImage.size.height)];
        [hardButton setBackgroundImage:cancelButtonImage forState:UIControlStateNormal];
        [okButton setFrame:CGRectMake(alertView.frame.size.width / 2 + 30,
                                      alertView.frame.size.height - okayButtonImage.size.height - 30,
                                      okayButtonImage.size.width,
                                      okayButtonImage.size.height)];

        [alertView insertSubview:hardButton atIndex:0];
        [alertView insertSubview:okButton atIndex:1];
    }
    [self addSubview:alertView];
    
    return self;
}


#pragma mark -
#pragma mark Custom alert methods
- (void)show
{
    isShown = YES;
    [UIView beginAnimations: @"Show Alert" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    self.alpha = 1;
    alertView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    alertView.alpha = 0;
    alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    alertView.alpha = 0.95;
    [UIView commitAnimations];
}

- (void)hide: (id)sender
{
    if (self.delegate)
        [self.delegate alertView:self willDismissWithButtonIndex:[[alertView subviews] indexOfObject:sender]];
    isShown = NO;
    [UIView beginAnimations:@"Hide Alert" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    self.alpha = 0.0;
    alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    alertView.alpha = 0;
    [UIView commitAnimations];
}

#pragma mark Animation delegate
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"Hide Alert"]) {
        if (finished) {
            [self removeFromSuperview];//Remove this alert view from super view
        }
    }
}
#pragma mark -
#pragma mark Utility Method
//Get alert right button
- (UIButton *) getRightButton:(NSString *) title {
    //Button Title Color
    CGFloat cmyka[5] = {0, 0.55, 1, 0.25, 1};
    UIColor *btnTitleColor = [DCCustomAlert getUIColorFromCMYK:cmyka];
    CGFloat cmykaShadow[5] = {0, 0.22, 0.54, 0, 1};
    UIColor *btnDropShadowColor = [DCCustomAlert getUIColorFromCMYK:cmykaShadow];
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [newButton setTitleShadowColor:btnDropShadowColor forState:UIControlStateNormal];
    [newButton.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
    [newButton.titleLabel setShadowOffset:CGSizeMake(0,1)];
    [newButton addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    [newButton setContentMode:UIViewContentModeScaleToFill];
    
    return newButton;
}
//Get alert left button
- (UIButton *) getLeftButton:(NSString *) title {
    //Button Title Color
    CGFloat cmyka[5] = {0, 0, 0, 0.6, 1};
    UIColor *btnTitleColor = [DCCustomAlert getUIColorFromCMYK:cmyka];
    CGFloat cmykaShadow[5] = {0, 0, 0, 0.05, 1};
    UIColor *btnDropShadowColor = [DCCustomAlert getUIColorFromCMYK:cmykaShadow];
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [newButton setTitleShadowColor:btnDropShadowColor forState:UIControlStateNormal];
    [newButton.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
    [newButton.titleLabel setShadowOffset:CGSizeMake(0,1)];
    [newButton addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    [newButton setContentMode:UIViewContentModeScaleToFill];
    
    return newButton;
}
+ (UIColor *) getUIColorFromCMYK:(CGFloat *)colors {
    CGColorSpaceRef cmykColorSpace = CGColorSpaceCreateDeviceCMYK();
    CGColorRef cgColor = CGColorCreate(cmykColorSpace, colors);
    return [UIColor colorWithCGColor:cgColor];
}
@end
