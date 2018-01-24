//
//  NJCustomNavigationBar.h
//  NJUIFrame
//
//  Created by 念纪 on 2018/1/5.
//  Copyright © 2018年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 如果自定义navigationBar，需要实现这几个方法，以防全局需要设置一些氛围之类的
 */
@protocol NJCustomNavigationBarView <NSObject>

- (void)setBackgroundColor:(UIColor *)color;
- (void)setBackgroundImage:(UIImage *)image;
- (void)setTitleColor:(UIColor *)titleColor;
- (void)setBarButtonItemColor:(UIColor *)color;

- (void)refreshWithNavigationItem:(UINavigationItem *)navigationItem;

@end

/**
 *  自定义的navigationBar, 每个页面一个
 */
@interface NJCustomNavigationBar : UIView <NJCustomNavigationBarView>

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSArray<UIView *> *leftBarButtonViews;
@property (nonatomic, copy) NSArray<UIView *> *rightBarButtonViews;

@end
