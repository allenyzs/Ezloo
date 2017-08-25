//
//  BaseNavController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/14/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = Skin_MainColor;
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName :[UIColor whiteColor]}];
    
    self.navigationBar.tintColor = Skin_MainColor;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

@end
