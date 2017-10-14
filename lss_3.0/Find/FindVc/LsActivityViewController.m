//
//  LsActivityViewController.m
//  lss
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsActivityViewController.h"
#import "LsActivityTableViewCell.h"
#import "LsActivityDetailViewController.h"

@interface LsActivityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)  UITableView              *tabView;

@end

@implementation LsActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle         =@"专题活动";
    superView.backgroundColor     =LSColor(243, 244, 245, 1);
    [superView addSubview:self.tabView];

}
#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell reloadCell:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsActivityDetailViewController *vc =[[LsActivityDetailViewController alloc] init];
    vc.title_                          =@"广东教师招聘笔面试全程班";
    vc.id_                             =@"123";
    [self.navigationController   pushViewController:vc animated:YES];
}

-(void)headerRefresh{
    [self.tabView reloadData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    [self.tabView reloadData];
    [self.tabView footerEndRefreshing];
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =LSColor(243, 244, 245, 1);
//        增加上拉下拉刷新事件
        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
