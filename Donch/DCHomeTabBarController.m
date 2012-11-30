//
//  DCHomeTabBarController.m
//  Donch
//
//  Created by Elisha Fu on 11/30/12.
//
//

#import "DCHomeTabBarController.h"
#import "DonchManager.h"
@interface DCHomeTabBarController ()

@end

@implementation DCHomeTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Customize UITransitionView to modify content height
    NSArray *views = [self.view subviews];
    UIView *UITransitionView = [views objectAtIndex:0];
    UITransitionView.frame = CGRectMake(0, 0, 320, 435);
    
    // Customize UITabBar
    UITabBar *tabBar = self.tabBar;
    UIImage *blank = [UIImage imageNamed:@"blank"];
    UIImage *bg = [UIImage imageNamed:@"tabBg@2x"];
    // have to add additional offset to cover item text 420 + 7
    tabBar.frame = CGRectMake(0, 430, 320, 44);
    tabBar.backgroundImage = bg;
    tabBar.selectionIndicatorImage = blank;
//    [self tabBar:self.tabBarController.tabBar didSelectItem:self.tabBarItem];
    
    // Customize UITabBarItem
    UIImage *exerciseSelected= [UIImage imageNamed:@"b1_click"];
    UIImage *exerciseNormal = [UIImage imageNamed:@"b1"];
    UIImage *targetSelected= [UIImage imageNamed:@"b2_click"];
    UIImage *targetNormal= [UIImage imageNamed:@"b2"];
    UIImage *recordSelected = [UIImage imageNamed:@"b3_click"];
    UIImage *recordNormal = [UIImage imageNamed:@"b3"];
    UIImage *settingsSelected = [UIImage imageNamed:@"b4_click"];
    UIImage *settingsNormal = [UIImage imageNamed:@"b4"];
    for (UITabBarItem *tabBarItem in tabBar.items)
    {
        if(tabBarItem.tag ==0 ){
            [tabBarItem setFinishedSelectedImage:exerciseSelected withFinishedUnselectedImage:exerciseNormal];
        }else if (tabBarItem.tag ==1){
            [tabBarItem setFinishedSelectedImage:targetSelected withFinishedUnselectedImage:targetNormal];
        }else if(tabBarItem.tag ==2){
            [tabBarItem setFinishedSelectedImage:recordSelected withFinishedUnselectedImage:recordNormal];
        }else{
            [tabBarItem setFinishedSelectedImage:settingsSelected withFinishedUnselectedImage:settingsNormal];
        }
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = viewController.view;
    NSInteger controllerIndex = [tabBarController.viewControllers indexOfObject:viewController];
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        if (finished) {
                            self.tabBarController.selectedIndex = controllerIndex;
                        }
                    }];
    return TRUE;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
