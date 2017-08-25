//
//  EZRegisterController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/16/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "EZRegisterController.h"

@interface EZRegisterController (){
    UIImageView *headerImageView;
    UITextField *userTextField;
    UITextField *passwordTextField;
    UITextField *reEnterPasswordTextField;
    UIButton *registerButton;
}

@end

@implementation EZRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    
    // create the view on the top
    
    headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/2.0)];
    headerImageView.image = [UIImage imageNamed:@"loginHeaderImage.png"];
    [self.view addSubview:headerImageView];
    
    // create the icon of username
    
    UIImageView *userName = [[UIImageView alloc] initWithFrame:CGRectMake(getAutoSizeX(42), CGRectGetMaxY(headerImageView.frame)+getAutoSizeY(30), getAutoSizeX(44), getAutoSizeX(44))];
    userName.image = [UIImage imageNamed:@"ic_account_circle_2x.png"];
    [self.view addSubview:userName];
    
    // create the textfield on the right side of the username's icon
    
    userTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userName.frame)+getAutoSizeX(5), userName.frame.origin.y, ScreenW-(2*getAutoSizeX(42)+getAutoSizeX(5)+getAutoSizeX(44)), getAutoSizeX(44))];
    userTextField.placeholder = @"Please enter your username";
    userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userTextField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:userTextField];
    
    // add a line under the textfield
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(userTextField.frame.origin.x, CGRectGetMaxY(userTextField.frame)-getAutoSizeY(0.5), userTextField.frame.size.width, getAutoSizeY(0.5))];
    line1.backgroundColor = Com_LineColor;
    [self.view addSubview:line1];
    
    // create the icon of password
    
    UIImageView *passwordEnter = [[UIImageView alloc] initWithFrame:CGRectMake(getAutoSizeX(42), CGRectGetMaxY(userName.frame)+getAutoSizeY(30), getAutoSizeX(44), getAutoSizeX(44))];
    passwordEnter.image = [UIImage imageNamed:@"ic_lock_2x.png"];
    [self.view addSubview:passwordEnter];
    
    // create the textfield on the right of the password's icon
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordEnter.frame)+getAutoSizeX(5), passwordEnter.frame.origin.y, ScreenW-(2*getAutoSizeX(42)+getAutoSizeX(5)+getAutoSizeX(44)), getAutoSizeX(44))];
    passwordTextField.placeholder = @"Please enter your password";
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.font = [UIFont systemFontOfSize:13];
    passwordTextField.secureTextEntry = YES;
    [self.view addSubview:passwordTextField];
    
    // add a line under the textfield
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(passwordTextField.frame.origin.x, CGRectGetMaxY(passwordTextField.frame)-getAutoSizeY(0.5), passwordTextField.frame.size.width, getAutoSizeY(0.5))];
    line2.backgroundColor = Com_LineColor;
    [self.view addSubview:line2];
    
    // create the icon of re-enter password
    
    UIImageView *reEnterPassword = [[UIImageView alloc] initWithFrame:CGRectMake(getAutoSizeX(42), CGRectGetMaxY(passwordEnter.frame)+getAutoSizeY(30), getAutoSizeX(44), getAutoSizeX(44))];
    reEnterPassword.image = [UIImage imageNamed:@"ic_lock_outline_2x.png"];
    [self.view addSubview:reEnterPassword];
    
    // create the textfield on the right of the reenter password's icon
    
    reEnterPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(reEnterPassword.frame)+getAutoSizeX(5), reEnterPassword.frame.origin.y, ScreenW - (2*getAutoSizeX(42)+getAutoSizeX(5)+getAutoSizeX(44)), getAutoSizeX(44))];
    reEnterPasswordTextField.placeholder = @"Re-enter your password";
    reEnterPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    reEnterPasswordTextField.font = [UIFont systemFontOfSize:13];
    reEnterPasswordTextField.secureTextEntry = YES;
    [self.view addSubview:reEnterPasswordTextField];
    
    // add a line under the textfield
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(reEnterPasswordTextField.frame.origin.x, CGRectGetMaxY(reEnterPasswordTextField.frame)-getAutoSizeY(0.5), reEnterPasswordTextField.frame.size.width, getAutoSizeY(0.5))];
    line3.backgroundColor = Com_LineColor;
    [self.view addSubview:line3];
    
    // add a register button below
    
    registerButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - getAutoSizeX(100))/2.0, CGRectGetMaxY(reEnterPasswordTextField.frame)+getAutoSizeY(30), getAutoSizeX(100), getAutoSizeY(40))];
    [registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [registerButton setTitleColor:Skin_MainColor forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [registerButton addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}

-(void) Register{
    if ([userTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""] || [reEnterPasswordTextField.text isEqualToString:@""]) {
        UIAlertView *emptyPlace = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter correct username or password!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [emptyPlace show];
    } else if (![passwordTextField.text isEqualToString: reEnterPasswordTextField.text]){
        UIAlertView *unmatchPassword = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unmatched password and re-enter password!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [unmatchPassword show];
    } else{
        UserInfo *newUser = [[UserInfo alloc] init];
        newUser.userName = userTextField.text;
        newUser.passWord = passwordTextField.text;
        UserInfo *pending = [UserInfo doLoadObjectFromUserInfoWhereUserName:newUser.userName];
        if (pending.userName != nil) {
            UIAlertView *alreadyReg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The username has been registered!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
            [alreadyReg show];
        } else{
            BOOL isSet = [newUser saveOrInsertUserInfo];
            if (isSet){
                [[NSUserDefaults standardUserDefaults] setObject:newUser.userName forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:newUser.passWord forKey:@"passWord"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //3.
                if (self.delegate && [self.delegate respondsToSelector:@selector(SendUserInfo:)]) {
                    [self.delegate SendUserInfo:newUser];
                }
                [self dismissViewControllerAnimated:YES completion:^{}];
            } else{
                UIAlertView *failReg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fail to register!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
                [failReg show];
            }
        };
    }
}
@end
