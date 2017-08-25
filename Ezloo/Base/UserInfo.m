//
//  UserInfo.m
//  Ezloo
//
//  Created by 杨卓树 on 8/17/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo
- (instancetype)initWithInfoDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.userName = [dic objectForKey:@"userName"];
        self.passWord = [dic objectForKey:@"passWord"];
    }
    return self;
}
//- (BOOL)insertUserInfo{
//    NSString *insertSQL = @"INSERT INTO UserInfo(userName,passWord) VALUES(?,?)";
//    __block BOOL ret = NO;
//    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
//        ret =
//        [db executeUpdate:insertSQL,self.userName,self.passWord,[NSKeyedArchiver archivedDataWithRootObject:self.itemArray]
//         ];
//        NSLog(@"表插入成功！");
//    }];
//    
//    return ret;
//}
//- (BOOL)saveUserInfo{
//    NSString *updateSQL = @"UPDATE UserInfo SET userName = ?,passWord = ?";
//    __block BOOL ret = NO;
//    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
//        ret =
//        [db executeUpdate:updateSQL,
//         self.userName,
//         self.passWord,
//         [NSKeyedArchiver archivedDataWithRootObject:self.itemArray]
//         ];
//        //NDLLog(@"会员表保存成功！");
//    }];
//    
//    return ret;
//}
- (BOOL)saveOrInsertUserInfo{
    NSString *replaceSQL = @"INSERT OR REPLACE INTO UserInfo(userName,passWord) VALUES(?,?)";
    
    __block BOOL ret = NO;
    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
        ret =
        [db executeUpdate:replaceSQL,
         self.userName,
         self.passWord,
         [NSKeyedArchiver archivedDataWithRootObject:self.itemArray]
         ];
        NSLog(@"插入表数据成功！");
    }];
    
    return ret;
}
//- (BOOL)deleteFromUserInfo{
//    NSString *deleteSQL = @"DELETE FROM UserInfo";
//    
//    __block BOOL ret = NO;
//    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
//        ret = [db executeUpdate:deleteSQL];
//    }];
//    //    NDLLog(@"数据删除会员表成功！");
//    
//    return ret;
//}
//+ (NSArray *)doLoadAllObjectFromUserInfo{
//    NSString *fetchSQL = @"SELECT * FROM UserInfo";
//    NSMutableArray *result = [[NSMutableArray alloc] init];
//    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:fetchSQL];
//        while ([rs next]) {
//            UserInfo *item = [[UserInfo alloc] init];
//            item.userName= [rs stringForColumn:@"userName"];
//            item.passWord= [rs stringForColumn:@"passWord"];
//            [result addObject:item];
//        }
//    }];
//    //    NDLLog(@"数据库查会员表成功！");
//    return result;
//}

+ (UserInfo *)doLoadObjectFromUserInfoWhereUserName:(NSString *)username {
    NSString *fetchSQL = [NSString stringWithFormat:@"SELECT * FROM UserInfo where userName = '%@'",username];
    UserInfo *item = [[UserInfo alloc] init];
    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:fetchSQL];
        while ([rs next]) {
            item.userName= [rs stringForColumn:@"userName"];
            item.passWord= [rs stringForColumn:@"passWord"];
        }
    }];
    //    NDLLog(@"数据库查single会员成功！");
    return item;
}

//+ (void)saveObjectsToUserInfoAsync:(NSArray *)objects withComplection:(void (^)(BOOL succeed))complection{
//    
//    BOOL succeed = NO;
//    for (UserInfo *data in objects) {
//        succeed = [data saveOrInsertUserInfo];
//        if (succeed == NO) {
//            break;
//        }
//    }
//    complection(succeed);
//}

@end
