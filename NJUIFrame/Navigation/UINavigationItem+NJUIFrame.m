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
#import "NJUIUtils.h"

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

static const char kNJUIFrame_CustomNavBar_Key;
- (UIView<NJCustomNavigationBarView> *)njCustomNavigationBar
{
    UIView<NJCustomNavigationBarView> *view = objc_getAssociatedObject(self, &kNJUIFrame_CustomNavBar_Key);
    if (!view) {
        view = [[NJCustomNavigationBar alloc] initWithFrame:[NJUIUtils navigationBarBounds]];
        objc_setAssociatedObject(self, &kNJUIFrame_CustomNavBar_Key, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setNjCustomNavigationBar:(UIView<NJCustomNavigationBarView> *)njCustomNavigationBar
{
    objc_setAssociatedObject(self, &kNJUIFrame_CustomNavBar_Key, njCustomNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UIBarButtonItem (NJUIFrame)

static const char kNJUIFrame_NavigationItem_ActionBlock_Key;
- (void (^)(void))njActionBlock
{
    return objc_getAssociatedObject(self, &kNJUIFrame_NavigationItem_ActionBlock_Key);
}

- (void)setNjActionBlock:(void (^)(void))njActionBlock
{
    objc_setAssociatedObject(self, &kNJUIFrame_NavigationItem_ActionBlock_Key, [njActionBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
