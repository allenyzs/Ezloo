//
//  EZRegisterController.h
//  Ezloo
//
//  Created by 杨卓树 on 8/16/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "BaseViewController.h"

//1.
@protocol RegisterDelegate <NSObject>

-(void)SendUserInfo:(UserInfo *)userinfo;

@end

@interface EZRegisterController : BaseViewController
//2.
@property(nonatomic,assign)id<RegisterDelegate>delegate;
@end
