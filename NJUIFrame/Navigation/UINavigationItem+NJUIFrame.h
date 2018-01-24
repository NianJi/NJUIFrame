//
//  UINavigationItem+NJUIFrame.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NJUIFrame/NJCustomNavigationBar.h>

@interface UINavigationItem (NJUIFrame)

@property (nonatomic, strong, readonly) UIBarButtonItem *njMoreBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *njLeftBarButtonItem;

// 每个页面自己的导航条， 默认是NJCustomNavigationBar
@property (nonatomic, strong) UIView<NJCustomNavigationBarView> *njCustomNavigationBar;

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@interface UIBarButtonItem (NJUIFrame)

@property (nonatomic, copy) void(^njActionBlock)(void);

@end
