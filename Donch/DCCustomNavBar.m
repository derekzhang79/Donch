//
//  DCCustomNavBar.m
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import "DCCustomNavBar.h"

@implementation DCCustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"navBar"];
    [image drawInRect:rect];
}

+ (UINavigationController*)navigationControllerWithRootViewController:(UIViewController*)aRootViewController
{
    //! load nib named the same as our custom class
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    //! get navigation controller from our xib and pass it the root view controller
    UINavigationController *navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    [navigationController setViewControllers:[NSArray arrayWithObject:aRootViewController] animated:NO];
    return navigationController;
}



@end
