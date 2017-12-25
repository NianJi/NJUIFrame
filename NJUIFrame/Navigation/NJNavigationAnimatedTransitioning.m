//
//  NJNavigationAnimatedTransitioning.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJNavigationAnimatedTransitioning.h"
#import <objc/runtime.h>
#import "NJNavigationBar.h"
#import "UINavigationItem+NJUIFrame.h"
#import "UIViewController+NJUIFrame.h"

const float kNJNavigationAnimationDuration = 0.35f;

@implementation UIViewController (NJSnapshot)

static const char NJNavigationAnimatedTransitioningNavSnapshotKey;
- (void)setNJNavBarSnapshot:(UIView *)view
{
    objc_setAssociatedObject(self, &NJNavigationAnimatedTransitioningNavSnapshotKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)NJNavBarSnapshot
{
    return objc_getAssociatedObject(self, &NJNavigationAnimatedTransitioningNavSnapshotKey);
}

static const char NJNavigationAnimatedTransitioningTabBarSnapshotKey;
- (void)setNJTabBarSnapshot:(UIView *)view
{
    objc_setAssociatedObject(self, &NJNavigationAnimatedTransitioningTabBarSnapshotKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)NJTabBarSnapshot
{
    return objc_getAssociatedObject(self, &NJNavigationAnimatedTransitioningTabBarSnapshotKey);
}

- (void)NJGenerateSnapshotViews
{
    // generate navigation bar
    UINavigationBar *topbarView = self.navigationController.navigationBar;
    if (!self.navigationController.navigationBarHidden && !topbarView.hidden) {
        CGRect frame = topbarView.bounds;
        if (topbarView.frame.origin.y == 20) {
            frame.origin.y = -20;
            frame.size.height += 21;
        }
        if (frame.size.height > 65) {
            frame.size.height = 65;
        }
        UIView *snapshot = [topbarView resizableSnapshotViewFromRect:frame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsMake(2, 2, frame.size.height-4, 2)];
        [self setNJNavBarSnapshot:snapshot];
    } else {
        [self setNJNavBarSnapshot:nil];
    }
    
    // generate tabbar view
    UITabBar *tabBar = self.tabBarController.tabBar;
    if (!self.hidesBottomBarWhenPushed && tabBar && !tabBar.hidden) {
        
        CGRect frame = tabBar.bounds;
        frame.origin.y -= 1;
        frame.size.height += 1;
        UIView *snapshot = [tabBar resizableSnapshotViewFromRect:frame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsMake(2, 2, frame.size.height-4, 2)];
        [self setNJTabBarSnapshot:snapshot];
    } else {
        [self setNJTabBarSnapshot:nil];
    }
}

@end

@implementation NJNavigationAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return kNJNavigationAnimationDuration;
}

- (void)setLeftShadowForView:(UIView *)view
{
    CALayer *shadowLayer = view.layer;
    shadowLayer.shadowRadius = 6;
    shadowLayer.shadowOpacity = 0.3;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-5, 0, 5, shadowLayer.frame.size.height)];
    shadowLayer.shadowPath = shadowPath.CGPath;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _inTransition = YES;
    
    NSLog(@"transition begin");
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (!self.isPop) {
        // push vc 逻辑
        [fromVC NJGenerateSnapshotViews];
        
        UIView *containerView = [transitionContext containerView];
        CGRect containerBounds = [containerView bounds];
        CGFloat width = CGRectGetWidth(containerBounds);
        
        // 设置 toVC的container
        UIView *toVCContainerView = [[UIView alloc] initWithFrame:containerBounds];
        toVCContainerView.backgroundColor = containerView.backgroundColor;
        [self setLeftShadowForView:toVCContainerView];
        [containerView addSubview:toVCContainerView];
        toVCContainerView.transform = CGAffineTransformMakeTranslation(width, 0);
        
        // 设置 toVC
        CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = finalRect;
        [toVCContainerView addSubview:toVC.view];
        
        // 设置真实的导航条
        UINavigationBar *navBar = nil;
        if ([toVC njHidesNavigationBar] && !self.navController.navigationBarHidden) {
            [self.navController setNavigationBarHidden:YES animated:NO];
        } else if (![toVC njHidesNavigationBar] && self.navController.navigationBarHidden) {
            [self.navController setNavigationBarHidden:NO animated:NO];
        }
        if (!self.navController.navigationBarHidden) {
            navBar = self.navController.navigationBar;
        }
        navBar.transform = CGAffineTransformMakeTranslation(width, 0);
        
        // 设置fromVC 上面的snapshot
        CGAffineTransform fromFinalTransform = CGAffineTransformMakeTranslation(-width/2., 0);
        UIView *navBarSnapshot = [fromVC NJNavBarSnapshot];
        if (navBarSnapshot) {
            [containerView insertSubview:navBarSnapshot belowSubview:toVCContainerView];
        }
        
        
        [UIView animateWithDuration:kNJNavigationAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCurlUp
                         animations:^{
                             
                             toVCContainerView.transform = CGAffineTransformIdentity;
                             fromVC.view.transform = fromFinalTransform;
                             navBarSnapshot.transform = fromFinalTransform;
                             navBar.transform = CGAffineTransformIdentity;
                             
                         } completion:^(BOOL finished) {
                             
                             NSLog(@"transition end");
                             fromVC.view.transform = CGAffineTransformIdentity;
                             navBarSnapshot.transform = CGAffineTransformIdentity;
                             [navBarSnapshot removeFromSuperview];
                             [containerView addSubview:toVC.view];
                             [toVCContainerView removeFromSuperview];
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    } else {
        
        // pop vc 逻辑
        UIView *containerView = [transitionContext containerView];
        CGRect containerBounds = [containerView bounds];
        CGFloat width = CGRectGetWidth(containerBounds);
    
        // 设置fromVC
        UIView *fromVCContainerView = [[UIView alloc] initWithFrame:containerBounds];
        fromVCContainerView.backgroundColor = containerView.backgroundColor;
        [self setLeftShadowForView:fromVCContainerView];
        [containerView addSubview:fromVCContainerView];
        [fromVCContainerView addSubview:fromVC.view];

        CGAffineTransform fromFinalTransform = CGAffineTransformMakeTranslation(width, 0);
        // 截图bar
        [fromVC NJGenerateSnapshotViews];
        UIView *navBarSnapshot = [fromVC NJNavBarSnapshot];
        if (navBarSnapshot) {
            [fromVCContainerView addSubview:navBarSnapshot];
        }
        
        // 设置真实的导航条
        UINavigationBar *navBar = self.navController.navigationBar;
        navBar.alpha = 0;
        
        // 设置 toVC
        CGRect toVcFinalRect = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = toVcFinalRect;
        toVC.view.transform = CGAffineTransformMakeTranslation(-width/2., 0);
        [containerView insertSubview:toVC.view belowSubview:fromVCContainerView];

        // 设置 toVC的 Navbar
        UIView *toVCNavBarSnapshot = [toVC NJNavBarSnapshot];
        if (toVCNavBarSnapshot) {
            [containerView insertSubview:toVCNavBarSnapshot belowSubview:fromVCContainerView];
            toVCNavBarSnapshot.transform = CGAffineTransformMakeTranslation(-width/2., 0);
        }
        
        // 设置 toVC 的 tabBar
        UIView *toTabBarSnapshot = [toVC NJTabBarSnapshot];
        UITabBar *bottomBarView = nil;
        if (toTabBarSnapshot) {
            bottomBarView = self.navController.tabBarController.tabBar;
            bottomBarView.hidden = YES;
                        
            CGRect toTabBarSnapshotFrame = toTabBarSnapshot.frame;
            toTabBarSnapshotFrame.origin = CGPointMake(0, CGRectGetHeight(containerBounds) - CGRectGetHeight(toTabBarSnapshotFrame));
            toTabBarSnapshot.frame = toTabBarSnapshotFrame;
            toTabBarSnapshot.transform = CGAffineTransformMakeTranslation(-width/2., 0);
            [containerView insertSubview:toTabBarSnapshot belowSubview:fromVCContainerView];
        }
        
        [UIView animateWithDuration:kNJNavigationAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCurlDown
                         animations:^{
                             
                             fromVCContainerView.transform = fromFinalTransform;
                             toVC.view.transform = CGAffineTransformIdentity;
                             toVCNavBarSnapshot.transform = CGAffineTransformIdentity;
                             toTabBarSnapshot.transform = CGAffineTransformIdentity;
                             
                         } completion:^(BOOL finished) {
                         
                             [toVCNavBarSnapshot removeFromSuperview];
                             [toTabBarSnapshot removeFromSuperview];
                             navBar.alpha = 1;

                             if (![transitionContext transitionWasCancelled]) {
                             
                                 bottomBarView.hidden = NO;
                                 [fromVC.view removeFromSuperview];
                                 [fromVCContainerView removeFromSuperview];
                                 NSLog(@"transition end");
                                 
                             } else {
                                 toVC.view.transform = CGAffineTransformIdentity;
                                 [toVC.view removeFromSuperview];
                                 toVCNavBarSnapshot.transform = CGAffineTransformIdentity;
                                 toTabBarSnapshot.transform = CGAffineTransformIdentity;
                                 
                                 [containerView addSubview:fromVC.view];
                                 [fromVCContainerView removeFromSuperview];
                                 NSLog(@"transition cancel");
                                 
                             }
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }

    
}

//- (id <UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext

- (void)animationEnded:(BOOL)transitionCompleted
{
    _inTransition = NO;
    if ([self.delegate respondsToSelector:@selector(NJNavigationTransitionDidCompleted:)]) {
        [self.delegate NJNavigationTransitionDidCompleted:self];
    }
}

@end
