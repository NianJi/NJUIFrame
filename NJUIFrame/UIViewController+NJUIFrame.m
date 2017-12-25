//
//  UIViewController+NJUIFrame.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "UIViewController+NJUIFrame.h"

@implementation UIViewController (NJUIFrame)

- (BOOL)njHidesNavigationBar
{
    return NO;
}

- (BOOL)njIsVisible
{
    return [self isViewLoaded] && self.view.window;
}

@end
