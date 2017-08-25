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
    
    UILabel *userInfoName = [[UILabel alloc] initWithFrame:CGRectMake(getAutoSizeX(40), getAutoSizeY(100), getAutoSizeX(100), getAutoSizeY(50))];
    userInfoName.text = @"UserName:";
    
    [self.view addSubview:userInfoName];
    
    UILabel *userInfoPassword = [[UILabel alloc] initWithFrame:CGRectMake(getAutoSizeX(40), CGRectGetMaxY(userInfoName.frame)+ getAutoSizeY(40), getAutoSizeX(100), getAutoSizeY(50))];
    userInfoPassword.text = @"Password:";
    
    [self.view addSubview:userInfoPassword];
}



@end
