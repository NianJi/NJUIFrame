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

@protocol NJUIInterfaceOrientationAppearance <NSObject>

- (UIInterfaceOrientationMask)supportedInterfaceOrientation;
- (BOOL)shouldAutorotate;
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end


@interface NJUIAppearance : NSObject

+ (instancetype)sharedAppearance;

@property (nonatomic, strong) id<NJUIColorAppearance> colorAppearance;
@property (nonatomic, strong) id<NJUIInterfaceOrientationAppearance> orientationAppearance;

@end
