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
    UILabel  *totalL;
}
@property (nonatomic,strong)   UITableView    *tabView;
@property (nonatomic,strong)   LsMyOrderModel *model;

@end

@implementation LsMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle      =@"我的钱包";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    [superView addSubview:self.tabView];
    totalL  =[[UILabel alloc]  initWithFrame:CGRectMake(0, LSMainScreenH-45*LSScale, LSMainScreenW, 45*LSScale)];
    totalL.backgroundColor    =LSNavColor;
    totalL.textAlignment      =NSTextAlignmentCenter;
    totalL.textColor          =[UIColor whiteColor];
    totalL.text               =@"共支出：60元";
    [superView addSubview:totalL];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"upCellID";
    LsMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsMyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsMyOrderModel  *model       =self.model.dataArray[indexPath.row];
    
    [cell reloadCellWithData:model];
    
    return cell;
}


-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.navView.frame)-20*LSScale-45*LSScale)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
    }
    return _tabView;
}

-(LsMyOrderModel *)model{
    if (!_model) {
        _model  =[[LsMyOrderModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
