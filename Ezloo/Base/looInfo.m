//
//  looInfo.m
//  Ezloo
//
//  Created by 杨卓树 on 8/25/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "looInfo.h"

@implementation looInfo
- (instancetype)initWithInfoDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.looName = [dic objectForKey:@"looName"];
        self.looAddress = [dic objectForKey:@"looAddress"];
    }
    return self;
}
- (BOOL)saveOrInsertlooInfo{
    NSString *replaceSQL = @"INSERT OR REPLACE INTO looInfo(looName,looAddress) VALUES(?,?)";
    
    __block BOOL ret = NO;
    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
        ret =
        [db executeUpdate:replaceSQL,
         self.looName,
         self.looAddress,
         [NSKeyedArchiver archivedDataWithRootObject:self.itemArray]
         ];
        NSLog(@"插入表数据成功！");
    }];
    
    return ret;
}
+ (BOOL)deleteFromLooInfo{
    NSString *deleteSQL = @"DELETE FROM looInfo";

    __block BOOL ret = NO;
    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:deleteSQL];
    }];
    //    NDLLog(@"数据删除会员表成功！");

    return ret;
}

+ (void)saveObjectsToLooInfoAsync:(NSMutableArray *)objects withComplection:(void (^)(BOOL succeed))complection{

    BOOL succeed = NO;
    [self deleteFromLooInfo];
    for (looInfo *data in objects) {
        succeed = [data saveOrInsertlooInfo];
        if (succeed == NO) {
            break;
        }
    }
    complection(succeed);
}

+ (NSMutableArray *)doLoadAllObjectFromLooInfo{
    NSString *fetchSQL = [NSString stringWithFormat:@"SELECT * FROM looInfo"];
    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
    [[[DBManager shareInstance] databaseQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:fetchSQL];
        while ([rs next]) {
            looInfo *item =[[looInfo alloc] init];
            item.looName= [rs stringForColumn:@"looName"];
            item.looAddress= [rs stringForColumn:@"looAddress"];
            [itemArr addObject:item];
        }
    }];
    
    return itemArr;
}

@end
