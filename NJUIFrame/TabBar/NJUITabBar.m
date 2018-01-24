//
//  NJUITabBar.m
//  NJUIFrame
//
//  Created by 念纪 on 2018/1/2.
//  Copyright © 2018年 Taobao lnc. All rights reserved.
//

#import "NJUITabBar.h"
#import "NJCustomTabBar.h"

@implementation NJUITabBar

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    
    sizeThatFits.height = self.customHeight;
    if (CGRectGetHeight([[UIScreen mainScreen] bounds]) == 812) {
        sizeThatFits.height += 34;
    }
        
    return sizeThatFits;
}

- (void)addSubview:(UIView *)view
{
    if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        
        // do nothing
        return;
    }
    [super addSubview:view];
}

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    if (![subview isKindOfClass:[NJCustomTabBar class]]) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            subview.hidden = YES;
        }
        [self sendSubviewToBack:subview];
    }
}

// FIX iPhoneX move up when push in Xcode9
- (void)setFrame:(CGRect)frame
{
    if (self.superview && CGRectGetMaxY(self.superview.bounds) != CGRectGetMaxY(frame)) {
        frame.origin.y = CGRectGetHeight(self.superview.bounds) - CGRectGetHeight(frame);
    }
    [super setFrame:frame];
}

@end
