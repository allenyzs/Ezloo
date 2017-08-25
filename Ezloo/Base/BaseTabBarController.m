//
//  BaseTabBarController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/14/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "EZUserMainController.h"
#import "EZUserNearbyController.h"
#import "EZUserMeController.h"
#import "BaseNavController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControllers];
}

- (void)initControllers {
    self.tabBar.tintColor = [[UIColor alloc] initWithRed:255/255.0 green:163/255.0 blue:0/255.0 alpha:1];
    
    // init view controllers
    EZUserMainController *FirstVC = [[EZUserMainController alloc] init];
    EZUserNearbyController *SecondVC = [[EZUserNearbyController alloc] init];
    EZUserMeController *ThirdVC = [[EZUserMeController alloc] init];
    
    // init navigation controllers
    BaseNavController *firstNav = [[BaseNavController alloc] initWithRootViewController:FirstVC];
    BaseNavController *secondNav = [[BaseNavController alloc] initWithRootViewController:SecondVC];
    BaseNavController *thirdNav = [[BaseNavController alloc] initWithRootViewController:ThirdVC];
    
    // add images to tab bar item
    firstNav.tabBarItem.image = [UIImage imageNamed:@"ic_home"];
    firstNav.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_home_tab"];
    firstNav.tabBarItem.title = @"Home";
    
    secondNav.tabBarItem.image = [UIImage imageNamed:@"ic_near_me"];
    secondNav.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_near_me_tab"];
    secondNav.tabBarItem.title = @"Nearby";
    
    thirdNav.tabBarItem.image = [UIImage imageNamed:@"ic_account_circle"];
    thirdNav.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_account_circle_tab"];
    thirdNav.tabBarItem.title = @"Me";
    
    // set the title of navigation
    
    FirstVC.navigationItem.title = @"Home";
    SecondVC.navigationItem.title = @"Nearby";
    ThirdVC.navigationItem.title = @"Me";
    
    self.viewControllers = @[firstNav, secondNav, thirdNav];
    self.selectedIndex = 0;
}
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

@end
