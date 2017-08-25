//
//  UserInfo.h
//  Ezloo
//
//  Created by 杨卓树 on 8/17/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *passWord;
@property(nonatomic,strong)NSArray *itemArray;
- (instancetype)initWithInfoDic:(NSDictionary *)dic;

- (BOOL)saveOrInsertUserInfo;
//+ (NSArray *)doLoadAllObjectFromUserInfo;
//
+ (UserInfo *)doLoadObjectFromUserInfoWhereUserName:(NSString *)userName;

@end
