//
//  EZUserMeController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/14/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "EZUserMeController.h"

@interface EZUserMeController ()

@end

@implementation EZUserMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void) createUI{
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    
    UILabel *userInfoName = [[UILabel alloc] initWithFrame:CGRectMake(getAutoSizeX(40), getAutoSizeY(100), getAutoSizeX(100), getAutoSizeY(50))];
    userInfoName.text = user;
    
    [self.view addSubview:userInfoName];
    
    UILabel *userInfoPassword = [[UILabel alloc] initWithFrame:CGRectMake(getAutoSizeX(40), CGRectGetMaxY(userInfoName.frame)+ getAutoSizeY(40), getAutoSizeX(100), getAutoSizeY(50))];
    userInfoPassword.text = password;
    
    [self.view addSubview:userInfoPassword];
//    [[NSUserDefaults standardUserDefaults] setObject:userTextField.text forKey:@"userName"];
//    [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"passWord"];
    
    
    
}



@end
