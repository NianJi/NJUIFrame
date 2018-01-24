//
//  NJUIAppearance.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJUIAppearance.h"
#import "NJUIAppearancePrivate.h"

@implementation NJUIAppearance

+ (instancetype)sharedAppearance
{
    static NJUIAppearance *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NJUIAppearance alloc] init];
    });
    return _instance;
}

- (UIColor *)viewBgColor
{
    id<NJUIColorAppearance> colorAppearance = self.colorAppearance;
    if ([colorAppearance respondsToSelector:@selector(viewBgColor)]) {
        return [colorAppearance viewBgColor];
    }
    return [UIColor whiteColor];
}

- (UIColor *)tabBarBgColor
{
    id<NJUIColorAppearance> colorAppearance = self.colorAppearance;
    if ([colorAppearance respondsToSelector:@selector(tabBarBgColor)]) {
        return [colorAppearance tabBarBgColor];
    }
    return [UIColor whiteColor];
}

- (UIColor *)navigationBarBgColor
{
    id<NJUIColorAppearance> colorAppearance = self.colorAppearance;
    if ([colorAppearance respondsToSelector:@selector(navigationBarBgColor)]) {
        return [colorAppearance navigationBarBgColor];
    }
    return [UIColor whiteColor];
}

#pragma mark - supported orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientation
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
