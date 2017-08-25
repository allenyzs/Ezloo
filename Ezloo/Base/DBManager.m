//
//  DBManager.m
//  Ezloo
//
//  Created by 杨卓树 on 8/16/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
@synthesize databaseQueue = _databaseQueue;
@synthesize databasePath = _databasePath;
+ (instancetype) shareInstance
{
    static DBManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[DBManager alloc] init];
        });
    
    return instance;
}

- (instancetype) init{
    if (self == [super init]) {
        [self.databaseQueue inDatabase:^(FMDatabase *db){
            NSString *userInfoSQL = @"create table if not exists UserInfo(username text, password text)";
            if (![db executeUpdate:userInfoSQL]) {
                NSLog(@"fail to create table of userInfo");
            } else{
                NSLog(@"succeed to create table of userInfo");
            }
        }];
    }
    return self;
}

- (FMDatabaseQueue *)databaseQueue{
    if (_databaseQueue == nil) {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.databasePath];
    }
    return _databaseQueue;
}

- (NSString *)databasePath{
    if (_databasePath == nil) {
        NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _databasePath = [libPath stringByAppendingPathComponent:@"Ezloo.sqlite"];
        NSLog(@"%@", _databasePath);
    }
    return _databasePath;
}
@end
