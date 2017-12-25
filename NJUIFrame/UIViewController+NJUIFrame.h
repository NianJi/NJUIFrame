//
//  UIViewController+NJUIFrame.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NJUIFrame)

/**
 *  可重载， 定义本vc是否需要导航条
 */
- (BOOL)njHidesNavigationBar;

/**
 *  当前vc是否是top vc.
 */
- (BOOL)njIsVisible;

/**
 *  下面两个方法可用来做通用降级操作，即把当前视图栈里面的自己pop掉，然后push一个新的vc替换自己
 */
- (void)njRedirectToViewController:(UIViewController *)viewController;
- (void)njRedirectToURL:(NSURL *)vcURL;


@property (nonatomic, assign) CGFloat njNavigationBarHeight;

@end
