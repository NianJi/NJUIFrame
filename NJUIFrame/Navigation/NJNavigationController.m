//
//  NJNavigationController.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJNavigationController.h"
#import "NJNavigationInteractiveTransitioningControl.h"
#import "NJNavigationAnimatedTransitioning.h"
#import "NJUIAppearancePrivate.h"
#import "NJNavigationBar.h"
#import "UIViewController+NJUIFrame.h"
#import "UINavigationItem+NJUIFrame.h"

typedef void (^NJTransitionBlock)(void);


@interface NJNavigationController () <NJNavigationAnimatedTransitioningDelegate, UINavigationBarDelegate>

@end

@implementation NJNavigationController

- (void)dealloc
{
    
}

- (void)setUp
{
    self.delegate = self;
    self.navigationBar.translucent = NO;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:[NJNavigationBar class] toolbarClass:NULL];
    if (self) {
        self.viewControllers = @[rootViewController];
        [self setUp];
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    NSAssert(delegate == self, @"NJNavigationController must set delegate to self");
    [super setDelegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[NJUIAppearance sharedAppearance] viewBgColor];
}

#pragma mark - animation object


- (void)NJNavigationTransitionDidCompleted:(NJNavigationAnimatedTransitioning *)transition
{
    
}

#pragma mark - overrides

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    if (!animated) {
        [self.topViewController NJGenerateSnapshotViews];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - navigationController delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"will show vc: %@", viewController);
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"did show vc: %@", viewController);
    // 设置navigationBar
    if ([viewController njHidesNavigationBar] && !self.navigationBarHidden) {
        [self setNavigationBarHidden:YES animated:NO];
    } else if (![viewController njHidesNavigationBar] && self.navigationBarHidden) {
        [self setNavigationBarHidden:NO animated:NO];
    }
    // 设置interaction control
    [viewController njInteractiveTransitionControl];
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return [(NJNavigationAnimatedTransitioning *)animationController ineractivePopTransition];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    id<NJNavigationAnimatedTransitioning> transition = nil;
    if (operation == UINavigationControllerOperationPush) {
        transition = [toVC njAnimatedTransitionPushFromViewController:fromVC];
        if (!transition) {
            transition = [fromVC njAnimatedTransitionPushToViewController:toVC];
        }
    } else if (operation == UINavigationControllerOperationPop) {
        transition = [fromVC njAnimatedTransitionPopToViewController:toVC];
        if (!transition) {
            transition = [toVC njAnimatedTransitionPopFromViewController:fromVC];
        }
        if (transition) {
            transition.ineractivePopTransition = [fromVC njInteractiveTransitionControl].interactivePopTransition;
        }
    }
    if (transition) {
        return transition;
    }
    
    NJNavigationAnimatedTransitioning *dTransition = [[NJNavigationAnimatedTransitioning alloc] init];
    dTransition.navController = self;
    dTransition.delegate = self;
    dTransition.ineractivePopTransition = [fromVC njInteractiveTransitionControl].interactivePopTransition;
    [toVC njInteractiveTransitionControl];
    dTransition.isPop = (operation == UINavigationControllerOperationPop);
    return dTransition;
}

#pragma mark - orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [[self.viewControllers lastObject] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [[self.viewControllers lastObject] preferredStatusBarStyle];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
