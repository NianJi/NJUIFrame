//
//  NJUIAppearance.h
//  NJUIFrame
//
//  Created by 念纪 on 2017/4/7.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NJUIColorAppearance <NSObject>

- (UIColor *)viewBgColor;
- (UIColor *)tabBarBgColor;
- (UIColor *)navigationBarBgColor;

@end

@interface NJUIAppearance : NSObject

+ (instancetype)sharedAppearance;

@property (nonatomic, strong) id<NJUIColorAppearance> colorAppearance;

@end
