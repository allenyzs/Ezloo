//
//  DBManager.h
//  Ezloo
//
//  Created by 杨卓树 on 8/16/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBManager : NSObject
@property (nonatomic , strong) FMDatabaseQueue *databaseQueue;
@property (nonatomic , strong) NSString *databasePath;
+ (instancetype)shareInstance;
@end
