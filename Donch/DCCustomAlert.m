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
    self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"alert-background"]];
    alertView.userInteractionEnabled = YES;
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id <DCCustomAlertDelegate>)myAlertViewDelegate
    okayButtonTitle:(NSString *)okayButtonTitle
  cancelButtonTitle:(NSString *)cancelButtonTitle
    alertBackground:(NSString *)alertBackground
           alertTag:(NSString *)tag {
    CGRect frame = CGRectMake(0,0, 640,480);
    self = [super initWithFrame:frame];
    self.delegate = myAlertViewDelegate;
    self.alertTag = tag;
    
    UIImage *alertBackgroundImage = [UIImage imageNamed:alertBackground];
    alertView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2 - alertBackgroundImage.size.width/2,
                                                              frame.size.height/2 - alertBackgroundImage.size.height/2,
                                                              alertBackgroundImage.size.width,
                                                              alertBackgroundImage.size.height)];
    alertView.image = alertBackgroundImage;
    
    [alertView addSubview:[self getTitleLabel:title]];
    [alertView addSubview:[self getMessageLabel:message]];
    
    BOOL singleButton = (cancelButtonTitle == nil & okayButtonTitle != nil);
    BOOL noButton = (cancelButtonTitle == nil & okayButtonTitle ==nil);
    
    UIButton *okButton = [self getRightButton:okayButtonTitle];
    UIImage *okButtonImg = [UIImage imageNamed:@"btn-yes-normal.png"];
    UIImage *okButtonPressedImg = [UIImage imageNamed:@"btn-yes-pressed"];
    [okButton setBackgroundImage:okButtonImg forState:UIControlStateNormal];
    [okButton setBackgroundImage:okButtonPressedImg forState:UIControlStateHighlighted];
    //Button Size : 153 * 56
    
    if (singleButton) {
        [okButton setFrame:CGRectMake(alertView.frame.size.width/2 - okButtonImg.size.width/2,
                                      alertView.frame.size.height - okButtonImg.size.height - 30,
                                      okButtonImg.size.width,
                                      okButtonImg.size.height)];
        [alertView insertSubview:okButton atIndex:0];
    }else if (noButton){
        // do nothing i think -elisha
    }else {
        UIButton *cancelButton = [self getLeftButton:cancelButtonTitle];
        UIImage *cancelButtonImg = [UIImage imageNamed:@"btn-no-normal"];
        UIImage *cancelButtonPressedImg = [UIImage imageNamed:@"btn-no-pressed"];
        [cancelButton setFrame:CGRectMake(50,
                                          alertView.frame.size.height - cancelButtonImg.size.height - 30,
                                          cancelButtonImg.size.width,
                                          cancelButtonImg.size.height)];
        [cancelButton setBackgroundImage:cancelButtonImg forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:cancelButtonPressedImg forState:UIControlStateHighlighted];
        [okButton setFrame:CGRectMake(alertView.frame.size.width - 200,
                                      alertView.frame.size.height - okButtonImg.size.height - 30,
                                      okButtonImg.size.width,
                                      okButtonImg.size.height)];
        [alertView insertSubview:okButton atIndex:0];
        [alertView insertSubview:cancelButton atIndex:1];
    }
    [self addSubview:alertView];
    
    return self;
}


#pragma mark -
#pragma mark Custom alert methods
- (void)show
{
    
    //  if (self.delegate)
    //  [self.delegate willPresentAlertView:self];
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
//get alert message label
- (UILabel *) getMessageLabel:(NSString *) message {
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, alertView.frame.size.width, 60)];
    messageLabel.font = [UIFont systemFontOfSize:24];
    CGFloat cmyka[5] = {0, 0, 0, 0.4, 1};
    messageLabel.textColor = [DCCustomAlert getUIColorFromCMYK:cmyka];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.shadowColor = [UIColor whiteColor];
    messageLabel.shadowOffset = CGSizeMake(0,1);
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return messageLabel;
}

//Get alert title label
- (UILabel *) getTitleLabel:(NSString *) title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, alertView.frame.size.width, 40)];
    titleLabel.font = [UIFont systemFontOfSize:30];
    CGFloat cmyka[5] = {0, 0, 0, 0.7, 1};
    titleLabel.textColor = [DCCustomAlert getUIColorFromCMYK:cmyka];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0,1);
    return titleLabel;
}
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
