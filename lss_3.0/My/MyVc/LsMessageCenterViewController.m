//
//  LsMessageCenterViewController.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMessageCenterViewController.h"
#import "LsMessageModel.h"
#import "LsMessageTableViewCell.h"

@interface LsMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)   LsMessageModel *model;
@property (nonatomic,strong)   UITableView    *tabView;

@end

@implementation LsMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"消息中心";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    [superView addSubview:self.tabView];
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)getData{
//    NSDictionary  *dict  =@{@"viewflag":@""};
    [[LsAFNetWorkTool shareManger] LSPOST:@"listcommmsg.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model   =[LsMessageModel yy_modelWithJSON:responseObject];
        [self.tabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"upCellID";
    LsMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsMessageModel  *model       =self.model.dataArray[indexPath.row];
    [cell reloadCellWithData:model];
    
    return cell;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.navView.frame)-20*LSScale)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
    }
    return _tabView;
}

-(LsMessageModel *)model{
    if (!_model) {
        _model  =[[LsMessageModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
