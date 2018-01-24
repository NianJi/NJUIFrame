//
//  UIViewController+NJUIFrame.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "UIViewController+NJUIFrame.h"
#import "NJUIAppearancePrivate.h"

@implementation UIViewController (NJUIFrame)

- (BOOL)njHidesNavigationBar
{
    return NO;
}

- (BOOL)njIsVisible
{
    return [self isViewLoaded] && self.view.window;
}

- (void)njRedirectToViewController:(UIViewController *)viewController
{
    if (viewController) {
        NSMutableArray *viewControllers = self.navigationController.viewControllers.mutableCopy;
        if (viewControllers) {
            if (viewControllers.count > 1) {
                [viewControllers removeLastObject];
            }
            [viewControllers addObject:viewController];
            [self.navigationController setViewControllers:viewControllers];
        }
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[NJUIAppearance sharedAppearance] supportedInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    return [[NJUIAppearance sharedAppearance] shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[NJUIAppearance sharedAppearance] preferredInterfaceOrientationForPresentation];
}

@end
