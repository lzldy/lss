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
{
    NSInteger    page;
}
@property (nonatomic,strong)   LsMessageModel *model;
@property (nonatomic,strong)   UITableView    *tabView;
@property (nonatomic,strong)   NSMutableArray *dataArray;

@end

@implementation LsMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"消息中心";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    [superView addSubview:self.tabView];
    [self getData];
}

-(void)getData{
//    viewflag：消息查看标志，空/Y/D,分别对应全部/已查看/删除
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [[LsAFNetWorkTool shareManger] LSPOST:@"listcommmsg.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model   =[LsMessageModel yy_modelWithJSON:responseObject];
        if (page>0) {
            [self.dataArray addObjectsFromArray:self.model.list];
        }else{
            self.dataArray =[NSMutableArray arrayWithArray:self.model.list];
        }
        if (self.dataArray.count>0) {
            [self.tabView reloadData];
            self.bgImageView.hidden  =YES;
            [superView bringSubviewToFront:self.tabView];
        }else{
            self.bgImageView.hidden  =NO;
            [superView bringSubviewToFront:self.bgImageView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"upCellID";
    LsMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsMessageModel  *model       =self.dataArray[indexPath.row];
    [cell reloadCellWithData:model];
    
    return cell;
}

-(void)headerRefresh{
    page =0;
    [self getData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    page ++;
    [self getData];
    [self.tabView footerEndRefreshing];
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.navView.frame)-20*LSScale)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
        //增加上拉下拉刷新事件
        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(LsMessageModel *)model{
    if (!_model) {
        _model  =[[LsMessageModel alloc] init];
    }
    return _model;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
