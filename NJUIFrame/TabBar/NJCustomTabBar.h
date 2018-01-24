//
//  NJCustomTabBar.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/12/25.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NJCustomTabBar;
@protocol NJCustomTabBarDelegate <NSObject>

- (void)customTabBar:(NJCustomTabBar *)tabBar didClickItemAtIndex:(NSUInteger)index;

@end

@interface NJCustomTabBar : UIView

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, weak) id<NJCustomTabBarDelegate> delegate;

@end
