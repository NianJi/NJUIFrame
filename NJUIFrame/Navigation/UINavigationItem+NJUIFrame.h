//
//  UINavigationItem+NJUIFrame.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (NJUIFrame)

@property (nonatomic, strong, readonly) UIBarButtonItem *njMoreBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *njLeftBarButtonItem;

@property (nonatomic, strong, readonly) UIImageView *njNavigationBarBackgroundView;

@end

@interface UIBarButtonItem (NJUIFrame)

@property (nonatomic, copy) void(^njActionBlock)();

@end
