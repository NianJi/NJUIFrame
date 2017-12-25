//
//  NJNavigationInteractiveTransitioning.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NJUIFrame/NJNavigationAnimatedTransitioning.h>

@interface NJNavigationInteractiveTransitioningControl : NSObject

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

- (instancetype)initWithViewController:(UIViewController *)nc;
 
@property(nonatomic, weak) UIViewController *parent;

@end


@interface UIViewController (NJNavigationInteractive)

@property (nonatomic, strong, readonly) NJNavigationInteractiveTransitioningControl *njInteractiveTransitionControl;

- (BOOL)njDisableInteractivePopTransition;


// 自定义转场动画, 由push的上一个vc来实现用这两个方法
- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPushToViewController:(UIViewController *)vc;
- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPopFromViewController:(UIViewController *)vc;

// 自定义转场动画, 由push到的vc来实现的话用这两个方法
- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPushFromViewController:(UIViewController *)vc;
- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPopToViewController:(UIViewController *)vc;

@end
