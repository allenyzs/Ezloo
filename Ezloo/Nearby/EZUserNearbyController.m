//
//  EZUserNearbyController.m
//  Ezloo
//
//  Created by 杨卓树 on 8/14/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#import "EZUserNearbyController.h"
#import "looInfo.h"
@interface EZUserNearbyController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tabView;
    NSMutableArray *dataArray;
}

@end

@implementation EZUserNearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self createUI];
}

- (void)createUI{
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64) style:UITableViewStylePlain];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabView];
}

-(void)initData{
    dataArray = [[NSMutableArray alloc] init];
    dataArray = [looInfo doLoadAllObjectFromLooInfo];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInfo"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellInfo"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (dataArray != nil && dataArray.count>0) {
            looInfo *item =dataArray[indexPath.row];
            cell.textLabel.text = item.looName;
            cell.detailTextLabel.text = item.looAddress;
        }
    }
    return cell;
}

@end
