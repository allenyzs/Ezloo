//
//  BaseViewController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/14/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backButtonImage = [[UIImage imageNamed:@"return_white"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 33, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.opaque = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
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
