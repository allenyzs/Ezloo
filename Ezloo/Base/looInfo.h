//
//  looInfo.h
//  Ezloo
//
//  Created by 杨卓树 on 8/25/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface looInfo : NSObject
@property(nonatomic,copy)NSString *looName;
@property(nonatomic,copy)NSString *looAddress;
@property(nonatomic,strong)NSArray *itemArray;
- (instancetype)initWithInfoDic:(NSDictionary *)dic;

- (BOOL)saveOrInsertLooInfo;
+ (NSMutableArray *)doLoadAllObjectFromLooInfo;
+ (void)saveObjectsToLooInfoAsync:(NSMutableArray *)objects withComplection:(void (^)(BOOL succeed))complection;
@end
