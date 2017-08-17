//
//  LsLiveViewController.m
//  lss
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveViewController.h"
#import "LsLiveTableViewCell.h"
#import "LsNavTabView.h"

@interface LsLiveViewController ()<lsNavTabViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  indexTabView;
}
@property (nonatomic,strong) LsNavTabView *topTabView;
@property (nonatomic,strong) UIScrollView *scrView;
@property (nonatomic,strong) UITableView *interviewTabView;//面试
@property (nonatomic,strong) UITableView *writtenTabView;//笔试

@end

@implementation LsLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"直播";
    [self.navView addSubview:self.topTabView];
    [self loadBaseUI];
}

-(void)loadBaseUI{
    [superView addSubview:self.scrView];
    [self.scrView addSubview:self.interviewTabView];
    [self.scrView addSubview:self.writtenTabView];
}
#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag==10010) {
        return 3;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (tableView.tag==10010) {
        [cell reloadCell:nil Type:@"2"];
    }else{
        [cell reloadCell:nil Type:@"2"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma - mark -    上下拉刷新
-(void)writtenTabViewHeaderRefresh{
    [self.writtenTabView reloadData];
    [self.writtenTabView headerEndRefreshing];
}

-(void)writtenTabViewFooterRefresh{
    [self.writtenTabView reloadData];
    [self.writtenTabView footerEndRefreshing];
}

-(void)interviewTabViewHeaderRefresh{
    [self.interviewTabView reloadData];
    [self.interviewTabView headerEndRefreshing];
}

-(void)interviewTabViewFooterRefresh{
    [self.interviewTabView reloadData];
    [self.interviewTabView footerEndRefreshing];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    LsLog(@"------------%d",index);
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:YES];
}

#pragma - mark -    懒加载
-(LsNavTabView *)topTabView{
    if (!_topTabView) {
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-80, 20+7, 160, 30)];
        _topTabView.delegate=self;
    }
    return _topTabView;
}

-(UITableView *)writtenTabView{
    if (!_writtenTabView) {
        _writtenTabView =[[UITableView alloc] initWithFrame:CGRectMake(LSMainScreenW,0, LSMainScreenW,self.scrView.frame.size.height)];
        _writtenTabView.delegate         =self;
        _writtenTabView.dataSource       =self;
        _writtenTabView.tableFooterView  =[[UIView alloc] init];
        _writtenTabView.showsVerticalScrollIndicator   =NO;
        _writtenTabView.tag              =10086;
        _writtenTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _writtenTabView.backgroundColor  =[UIColor clearColor];
        //增加上拉下拉刷新事件
        [_writtenTabView addHeaderWithTarget:self action:@selector(writtenTabViewHeaderRefresh)];
        [_writtenTabView addFooterWithTarget:self action:@selector(writtenTabViewFooterRefresh)];
    }
    return _writtenTabView;
}

-(UITableView *)interviewTabView{
    if (!_interviewTabView) {
        _interviewTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW,self.scrView.frame.size.height)];
        _interviewTabView.delegate         =self;
        _interviewTabView.dataSource       =self;
        _interviewTabView.tableFooterView  =[[UIView alloc] init];
        _interviewTabView.showsVerticalScrollIndicator   =NO;
        _interviewTabView.tag              =10010;
        _interviewTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _interviewTabView.backgroundColor  =[UIColor clearColor];
        //增加上拉下拉刷新事件
        [_interviewTabView addHeaderWithTarget:self action:@selector(interviewTabViewHeaderRefresh)];
        [_interviewTabView addFooterWithTarget:self action:@selector(interviewTabViewFooterRefresh)];
    }
    return _interviewTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame),LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
//        _scrView.userInteractionEnabled           =NO;
    }
    return _scrView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
