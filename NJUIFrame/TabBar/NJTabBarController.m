//
//  NJTabBarController.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJTabBarController.h"
#import "NJUIAppearancePrivate.h"
#import "NJCustomTabBar.h"
#import "NJUITabBar.h"
#import <objc/runtime.h>
#import <OCSafeMethod/OCSafeMethod.h>

@interface NJTabBarController () <NJCustomTabBarDelegate>

@end

@implementation NJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.view.backgroundColor = [[NJUIAppearance sharedAppearance] viewBgColor];
    
    object_setClass(self.tabBar, [NJUITabBar class]);
    [(NJUITabBar *)self.tabBar setCustomHeight:44];
    [self.tabBar sizeToFit];
    
    NJCustomTabBar *customTabBar = [[NJCustomTabBar alloc] initWithFrame:self.tabBar.bounds];
    customTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom tabbar delegate

- (void)customTabBar:(NJCustomTabBar *)tabBar didClickItemAtIndex:(NSUInteger)index
{
    self.selectedIndex = index;
}

#pragma mark - orientation support

- (UIViewController *)topViewController
{
    UIViewController *ret = [self.viewControllers objectAtIndex:self.selectedIndex];
    if ([ret isKindOfClass:[UINavigationController class]]) {
        ret = [(UINavigationController *)ret topViewController];
    }
    return ret;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self topViewController] supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    return [[self topViewController] shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self topViewController] preferredInterfaceOrientationForPresentation];
}

@end
