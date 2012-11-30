//
//  DCCustomAlert.h
//  Donch
//
//  Created by Ryan on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@protocol DCCustomAlertDelegate;

@interface DCCustomAlert : UIView {
    CGPoint lastTouchLocation;
}
@property (nonatomic) id<DCCustomAlertDelegate> delegate;
@property (nonatomic) BOOL isShown;
@property (nonatomic) UIImageView *alertView;
@property (nonatomic) NSString *alertTag;

- (void)show;
- (void)hide: (id)sender;
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id <DCCustomAlertDelegate>)delegate
    okayButtonTitle:(NSString *)okayButtonTitle
  cancelButtonTitle:(NSString *)cancelButtonTitle
    alertBackground:(NSString *)alertBackground
           alertTag:(NSString *)tag;

@end

@protocol DCCustomAlertDelegate <NSObject>
@optional
- (void)willPresentAlertView:(DCCustomAlert *)alertView;
- (void)alertView:(DCCustomAlert *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
@end