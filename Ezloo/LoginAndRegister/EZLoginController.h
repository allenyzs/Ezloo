//
//  EZLoginController.h
//  Ezloo
//
//  Created by 杨卓树 on 8/15/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "BaseViewController.h"

@protocol loginDelegate <NSObject>

- (void) login;

@end
@interface EZLoginController : BaseViewController
@property(nonatomic,assign)id<loginDelegate>delegate;
@end
