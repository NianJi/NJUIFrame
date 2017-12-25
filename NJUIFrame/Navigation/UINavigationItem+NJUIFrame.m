//
//  UINavigationItem+NJUIFrame.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "UINavigationItem+NJUIFrame.h"
#import <objc/runtime.h>
#import "NJUIAppearancePrivate.h"

@implementation UINavigationItem (NJUIFrame)

static const char kNJUIFrame_NavigationItem_MoreButton_Key;
- (UIBarButtonItem *)njMoreBarButtonItem
{
    UIBarButtonItem *item = objc_getAssociatedObject(self, &kNJUIFrame_NavigationItem_MoreButton_Key);
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:@"···" style:UIBarButtonItemStylePlain target:self action:@selector(njNavigationBarButtonItemClicked:)];
        objc_setAssociatedObject(self, &kNJUIFrame_NavigationItem_MoreButton_Key, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

static const char kNJUIFrame_NavigationItem_BackButton_Key;
- (UIBarButtonItem *)njLeftBarButtonItem
{
    UIBarButtonItem *item = objc_getAssociatedObject(self, &kNJUIFrame_NavigationItem_BackButton_Key);
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(njNavigationBarButtonItemClicked:)];
        objc_setAssociatedObject(self, &kNJUIFrame_NavigationItem_BackButton_Key, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

- (void)njNavigationBarButtonItemClicked:(UIBarButtonItem *)item
{
    void (^actionBlock)(void) = item.njActionBlock;
    if (actionBlock) {
        actionBlock();
    }
}

static const char kNJUIFrame_NavigationItem_BarBgView_Key;
- (UIImageView *)njNavigationBarBackgroundView
{
    UIImageView *bgView = objc_getAssociatedObject(self, &kNJUIFrame_NavigationItem_BarBgView_Key);
    if (!bgView) {
        CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
        bgView.backgroundColor = [[NJUIAppearance sharedAppearance] navigationBarBgColor];
        objc_setAssociatedObject(self, &kNJUIFrame_NavigationItem_BarBgView_Key, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return bgView;
}

@end


@implementation UIBarButtonItem (NJUIFrame)

static const char kNJUIFrame_NavigationItem_ActionBlock_Key;
- (void (^)())njActionBlock
{
    return objc_getAssociatedObject(self, &kNJUIFrame_NavigationItem_ActionBlock_Key);
}

- (void)setTmActionBlock:(void (^)())njActionBlock
{
    objc_setAssociatedObject(self, &kNJUIFrame_NavigationItem_ActionBlock_Key, [njActionBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
