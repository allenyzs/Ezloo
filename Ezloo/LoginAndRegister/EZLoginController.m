//
//  EZLoginController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/15/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "EZLoginController.h"
#import "EZRegisterController.h"
#import "BaseTabBarController.h"
//4.
@interface EZLoginController ()<RegisterDelegate>{
    UIImageView *headerImageView;
    UITextField *userTextField;
    UITextField *passwordTextField;
    UIButton *signInButton;
    UIButton *registerButton;
}

@end

@implementation EZLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark - create UI
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
    NSString *userNa =[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if (![userNa isEqualToString:@""])  {
        userTextField.text = userNa;
    }
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
    
    // create a sign in button
    
    signInButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - getAutoSizeX(100))/2.0, CGRectGetMaxY(passwordEnter.frame)+ getAutoSizeY(40), getAutoSizeX(100), getAutoSizeY(40))];
    [signInButton setTitle: @"Sign In" forState: UIControlStateNormal];
    [signInButton setTitleColor: Skin_MainColor forState:UIControlStateNormal];
    signInButton.titleLabel.font = [UIFont boldSystemFontOfSize: 25];
    [signInButton addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    // add a line below the sign in button
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - getAutoSizeX(110))/2.0, CGRectGetMaxY(signInButton.frame) + getAutoSizeY(5), getAutoSizeX(110), getAutoSizeY(1))];
    line3.backgroundColor = Com_LineColor;
    [self.view addSubview:line3];
    
    // create a register button
    
    registerButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - getAutoSizeX(100))/2.0, CGRectGetMaxY(line3.frame) + getAutoSizeY(5), getAutoSizeX(100), getAutoSizeY(40))];
    [registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [registerButton setTitleColor:Skin_MainColor forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    [registerButton addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}
-(void)Login{
    
    UserInfo *uPending = [UserInfo doLoadObjectFromUserInfoWhereUserName:userTextField.text];
    
    if ([userTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""]) {
        UIAlertView *emptyLogin = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter correct username or password!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [emptyLogin show];
    } else if (uPending.userName == nil){
        UIAlertView *errorUserName = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter correct username!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [errorUserName show];
    } else if (uPending.passWord != passwordTextField.text){
        UIAlertView *errorPassword = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter correct password!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [errorPassword show];
    } else if (uPending.userName != nil && uPending.passWord == passwordTextField.text){
        if (self.delegate && [self.delegate respondsToSelector:@selector(login)]) {
            [[NSUserDefaults standardUserDefaults] setObject:userTextField.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"passWord"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.delegate login];
        }
    }
    
    
}

-(void)Register{
    EZRegisterController *vcReg = [[EZRegisterController alloc] init];
   //5.
    vcReg.delegate = self;
    [self presentViewController:vcReg animated:YES completion:^{}];
}
#pragma mark -RegisterDelegate
-(void)SendUserInfo:(UserInfo *)userinfo
{
    userTextField.text = userinfo.userName;
//    passwordTextField.text = userinfo.passWord
}
@end
