//
//  NJNavigationBar.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJNavigationBar.h"
#import "UINavigationItem+NJUIFrame.h"

@interface NJNavigationBar () <UINavigationBarDelegate>
{
    UIImageView *_currentBackgroundImageView;
}

@property (nonatomic, strong) UIView *backgroundContainerView;

@end

@implementation NJNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (UIView *)backgroundContainerView
{
    if (!_backgroundContainerView) {
        _backgroundContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 64)];
        [self addSubview:_backgroundContainerView];
    }
    return _backgroundContainerView;
}

- (void)setBackgroundImageView:(UIImageView *)imageView
{
    if (imageView != _currentBackgroundImageView) {
        [_currentBackgroundImageView removeFromSuperview];
        _currentBackgroundImageView = imageView;
        [self.backgroundContainerView addSubview:imageView];
    }
}

- (void)didAddSubview:(UIView *)subview
{
    if (self.backgroundContainerView) {
        [self sendSubviewToBack:self.backgroundContainerView];
    }
    if ([subview isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
        subview.hidden = YES;
    }
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated
{
    return [super popNavigationItemAnimated:animated];
}

- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated
{
    [super pushNavigationItem:item animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UINavigationItem *topItem  = [self topItem];
    if (topItem) {
        UIImageView *topImageView = [topItem njNavigationBarBackgroundView];
        if (topImageView != _currentBackgroundImageView) {
            [self setBackgroundImageView:topImageView];
        }
    }
}

@end
