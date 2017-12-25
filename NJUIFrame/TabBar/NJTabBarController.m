//
//  NJTabBarController.m
//  NJUIFrame
//
//  Created by 念纪 on 2017/3/14.
//  Copyright © 2017年 Taobao lnc. All rights reserved.
//

#import "NJTabBarController.h"
#import "NJUIAppearancePrivate.h"

@interface NJTabBarController ()

@end

@implementation NJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.view.backgroundColor = [[NJUIAppearance sharedAppearance] viewBgColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
