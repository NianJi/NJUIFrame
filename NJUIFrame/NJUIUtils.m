//
//  NJUIUtils.m
//  NJUIFrame
//
//  Created by 念纪 on 2018/1/5.
//  Copyright © 2018年 Taobao lnc. All rights reserved.
//

#import "NJUIUtils.h"

@implementation NJUIUtils

+ (CGRect)navigationBarBounds
{
    UINavigationController *navVC = [self currentNavigationController];
    if (navVC) {
        return [[navVC navigationBar] bounds];
    } else {
        return CGRectZero;
    }
}

+ (UINavigationController *)currentNavigationController
{
    id rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        id selectVC = [(UITabBarController *)rootVC selectedViewController];
        if ([selectVC isKindOfClass:[UINavigationController class]]) {
            return selectVC;
        }
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return rootVC;
    }
    return nil;
}

+ (UIViewController *)currentViewController {
    UINavigationController *navVC = [self currentNavigationController];
    return [[navVC viewControllers] lastObject];
}

@end
