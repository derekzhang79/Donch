//
//  DCCustomAlert.h
//  Donch
//
//  Created by Ryan on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@protocol DCCustomAlertDelegate;

@interface DCCustomAlert : UIView

@property (nonatomic) id<DCCustomAlertDelegate> delegate;
@property (nonatomic) BOOL isShown;
@property (nonatomic) UIImageView *alertView;

- (void)show;
- (void)hide: (id)sender;
- (id)initWIthMessageImage:(UIImage *) messageImage
                  delegate:(id <DCCustomAlertDelegate>) alertDelegate
           okayButtonImage:(UIImage *) okayButtonImage
         cancelButtonTitle:(UIImage *) cancelButtonImage;

@end

@protocol DCCustomAlertDelegate <NSObject>
@optional
- (void)willPresentAlertView:(DCCustomAlert *)alertView;
- (void)alertView:(DCCustomAlert *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
@end