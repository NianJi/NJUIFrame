//
//  NJNavigationInteractiveTransitioning.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJNavigationInteractiveTransitioningControl.h"
#import <objc/runtime.h>

@interface NJNavigationInteractiveTransitioningControl () <UIGestureRecognizerDelegate>

@end

@implementation NJNavigationInteractiveTransitioningControl
{
    CGFloat _startScale;
}

- (instancetype)initWithViewController:(UIViewController *)nc
{
    if (self = [super init])
    {
        _parent = nc;
        
        if (![nc njDisableInteractivePopTransition]) {
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            panGesture.delegate = self;
            [_parent.view addGestureRecognizer:panGesture];
        }
        
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGFloat progress = [recognizer translationInView:self.parent.view].x / CGRectGetWidth(self.parent.view.frame);
    CGFloat velocity = [recognizer velocityInView:self.parent.view].x;
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.parent.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        // Finish or cancel the interactive transition
        if (progress > 0.4 || velocity > 2000) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer
{
    return [recognizer velocityInView:self.parent.view].x > 0;
}

@end


@implementation UIViewController (NJNavigationInteractive)

static const char NJNavigationInteractiveTransitionKey;
- (NJNavigationInteractiveTransitioningControl *)njInteractiveTransitionControl
{
    NJNavigationInteractiveTransitioningControl *control = objc_getAssociatedObject(self, &NJNavigationInteractiveTransitionKey);
    if (!control) {
        control = [[NJNavigationInteractiveTransitioningControl alloc] initWithViewController:self];
        objc_setAssociatedObject(self, &NJNavigationInteractiveTransitionKey, control, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return control;
}

- (BOOL)njDisableInteractivePopTransition
{
    return NO;
}

// 自定义转场动画, 由push的上一个vc来实现用这两个方法
- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPushToViewController:(UIViewController *)vc
{
    return nil;
}

- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPopFromViewController:(UIViewController *)vc
{
    return nil;
}

// 自定义转场动画, 由push到的vc来实现的话用这两个方法
- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPushFromViewController:(UIViewController *)vc
{
    return nil;
}

- (id<NJNavigationAnimatedTransitioning>)njAnimatedTransitionPopToViewController:(UIViewController *)vc
{
    return nil;
}

@end
