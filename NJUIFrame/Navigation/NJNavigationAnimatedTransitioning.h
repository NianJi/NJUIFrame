//
//  NJNavigationAnimatedTransitioning.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NJNavigationAnimatedTransitioning;
@class NJNavigationInteractiveTransitioning;
@protocol NJNavigationAnimatedTransitioningDelegate <NSObject>

- (void)NJNavigationTransitionDidCompleted:(NJNavigationAnimatedTransitioning *)transition;

@end

/**
 *  导航条转场动画类
 */
@protocol NJNavigationAnimatedTransitioning <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *ineractivePopTransition;

@end

@interface NJNavigationAnimatedTransitioning : NSObject <NJNavigationAnimatedTransitioning>

@property (nonatomic, weak) UINavigationController *navController;
@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, weak) id<NJNavigationAnimatedTransitioningDelegate> delegate;
@property (nonatomic, assign, readonly, getter=isInTransition) BOOL inTransition;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *ineractivePopTransition;

@end


@interface UIViewController (NJSnapshot)

@property (nonatomic, strong) UIView *NJNavBarSnapshot;
@property (nonatomic, strong) UIView *NJTabBarSnapshot;

- (void)NJGenerateSnapshotViews;

@end
