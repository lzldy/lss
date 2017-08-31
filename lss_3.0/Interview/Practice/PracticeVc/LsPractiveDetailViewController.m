//
//  LsPractiveDetailViewController.m
//  lss
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPractiveDetailViewController.h"

@interface LsPractiveDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tabView;
@end

@implementation LsPractiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    self.navView.navTitle =self.authorType;
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIButton *videoBtn             =[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 130*LSScale)];
    videoBtn.backgroundColor       =[UIColor greenColor];
    [superView addSubview:videoBtn];
    
    UIView   *headerView           =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(videoBtn.frame), LSMainScreenW, 50*LSScale)];
    headerView.backgroundColor     =[UIColor blueColor];
    [superView addSubview:headerView];
    
    UIView  *commentView           =[[UIView alloc] init];
    commentView.backgroundColor    =[UIColor brownColor];
    [superView addSubview:commentView];
    
    _tabView =[[UITableView alloc] init];
    _tabView.delegate         =self;
    _tabView.dataSource       =self;
    _tabView.tableFooterView  =[[UIView alloc] init];
    _tabView.showsVerticalScrollIndicator   =NO;
    _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
    _tabView.backgroundColor  =[UIColor redColor];
    //增加上拉下拉刷新事件
    [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    [superView addSubview:_tabView];
    
    if ([self.authorType isEqualToString:@"学生"]) {
        commentView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame)+10*LSScale, LSMainScreenW, 40*LSScale);
        _tabView.frame    = CGRectMake(0, CGRectGetMaxY(commentView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-10*LSScale-CGRectGetMaxY(commentView.frame));
    }else{
        _tabView.frame    = CGRectMake(0, CGRectGetMaxY(headerView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-10*LSScale-CGRectGetMaxY(headerView.frame));
    }
}

-(void)headerRefresh{
    [self.tabView reloadData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    [self.tabView reloadData];
    [self.tabView footerEndRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    //    return self.model.practiceDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *sectionIDD = @"section1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionIDD];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionIDD];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    LsPracticeListModel *model =self.model.practiceDataArray[indexPath.row];
//    [cell reloadCell:model Type:@"2"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LsPracticeListModel *model            =self.model.practiceDataArray[indexPath.row];
//    LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
//    //    praVc.authorType                      =model.authorType ;
//    praVc.authorType                      =@"学生";
//    [self.navigationController pushViewController:praVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
