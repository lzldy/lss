//
//  LsLiveBroadcastViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsInterviewViewController.h"
#import "UCCarouselView.h"
#import "LsInterViewTableViewCell.h"
#import "LsInterView.h"
#import "LsInterCellHeaderView.h"

static NSString *cellId = @"cellId";

@interface LsInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate>

@property (nonatomic,strong)  NSArray                  *bannerArray;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UCCarouselView           *carouselView;
@property (nonatomic,strong)  LsInterView              *typeView;

@end

@implementation LsInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"面试";
    [self getUserInfo];
    [self initData];
    [self loadBaseUI];
}

-(void)getUserInfo{
    
}

-(void)initData{
    _bannerArray = @[LOADIMAGEWITHTYPE(@"banner1", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner2", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner3", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner4", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner5", @"jpg")];
}

-(void)loadBaseUI{
    [self loadCarouselViewWithTimer];
    [superView addSubview:self.typeView];
    [superView addSubview:self.tabView];
//    self.tabView.tableHeaderView  =self.cellHeaderView;

}

// 使用定时器初始化
- (void)loadCarouselViewWithTimer {

    _carouselView  =[[UCCarouselView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 140*LSScale)
                                                dataArray:_bannerArray
                                             timeInterval:2
                                       didSelectItemBlock:^(NSInteger didSelectItem){
          LsLog(@"--------------%d",didSelectItem);
    }];
    [superView addSubview:_carouselView];
}

#pragma - mark -   UITableView 代理
-(void)headerRefresh{
    [self.tabView reloadData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    [self.tabView reloadData];
    [self.tabView footerEndRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LsInterViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LsInterViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    LsInterCellHeaderView *cellHeaderView =[[LsInterCellHeaderView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 45)];
     [cellHeaderView setLeftTitle:@"最新直播" AndRightTitle:@"更多"];
    return cellHeaderView;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 30);
//    return view;
//}

- (void)didClickHeaderViewIndex:(NSInteger)index{
    LsLog(@"+++++++++++++++++===%d",index);
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.typeView.frame)-49)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =LSColor(243, 244, 245, 1);
        //增加上拉下拉刷新事件
        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(LsInterView *)typeView{
    if (!_typeView) {
        _typeView =[[LsInterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carouselView.frame), LSMainScreenW, 80)];
        _typeView.dataArray =@[@{@"title":@"直播",@"imageName":@"zhibo"},
                                 @{@"title":@"练课",@"imageName":@"lianke"},
                                 @{@"title":@"资料",@"imageName":@"ziliao"},
                                 @{@"title":@"公告",@"imageName":@"gonggao"}];
        _typeView.delegate=self;
    }
    return _typeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
