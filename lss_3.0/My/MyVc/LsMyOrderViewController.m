//
//  LsMyOrderViewController.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyOrderViewController.h"
#import "LsMyOrderTableViewCell.h"
#import "LsMyOrderModel.h"

@interface LsMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel      *totalL;
    NSInteger    page;
}
@property (nonatomic,strong)   UITableView    *tabView;
@property (nonatomic,strong)   LsMyOrderModel *model;
@property (nonatomic,strong)   NSMutableArray *dataArray;

@end

@implementation LsMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle      =@"我的订单";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
    [self getData];
}

-(void)getData{

    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [[LsAFNetWorkTool shareManger] LSPOST:@"listorders.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model  =[LsMyOrderModel yy_modelWithJSON:responseObject];
        if (page>0) {
            [self.dataArray addObjectsFromArray:self.model.list];
        }else{
            self.dataArray =[NSMutableArray arrayWithArray:self.model.list];
        }
        [self.tabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)loadBaseUI{
    [superView addSubview:self.tabView];
//    totalL  =[[UILabel alloc]  initWithFrame:CGRectMake(0, LSMainScreenH-45*LSScale, LSMainScreenW, 45*LSScale)];
//    totalL.backgroundColor    =LSNavColor;
//    totalL.textAlignment      =NSTextAlignmentCenter;
//    totalL.textColor          =[UIColor whiteColor];
//    totalL.text               =@"共支出：60元";
//    [superView addSubview:totalL];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"upCellID";
    LsMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsMyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsMyOrderModel  *model       =self.dataArray[indexPath.row];
    
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
    NSLog(@"----------%ld",(long)page);
    //加载更多数据
    [self getData];
    //结束刷新
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

-(LsMyOrderModel *)model{
    if (!_model) {
        _model  =[[LsMyOrderModel alloc] init];
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
