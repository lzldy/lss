//
//  LsDataViewController.m
//  lss
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsDataViewController.h"
#import "LsNavTabView.h"
#import "LsDataTableViewCell.h"
#import "LsDataModel.h"

@interface LsDataViewController ()<lsNavTabViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL       isScroll;
    float      startY;

}
@property (nonatomic,strong)  LsNavTabView             *topTabView;
@property (nonatomic,strong)  UIScrollView             *scrView;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  LsDataModel              *model;
@end

@implementation LsDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"资料";
    superView.backgroundColor                  =LSColor(243, 244, 245, 1);
    [self.navView addSubview:self.topTabView];
    [self getData];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"listinfo.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model =[LsDataModel yy_modelWithJSON:responseObject];
        [self loadBaseUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

-(void)loadBaseUI{
    [superView addSubview:self.scrView];
    [self.scrView addSubview:self.tabView];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma - mark -    上下拉刷新
-(void)writtenTabViewHeaderRefresh{
    isScroll=NO;
//    [self getWrittenData];
}

-(void)writtenTabViewFooterRefresh{
    isScroll=NO;
    
    //    [self.writtenTabView reloadData];
//    [self.writtenTabView footerEndRefreshing];
}

-(void)interviewTabViewHeaderRefresh{
    isScroll=NO;
//    [self getInterviewData];
}

-(void)interviewTabViewFooterRefresh{
    isScroll=NO;
    
    //    [self.interviewTabView reloadData];
//    [self.interviewTabView footerEndRefreshing];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
//        [self.interviewTabView headerBeginRefreshing];
    }else{
//        [self.writtenTabView headerBeginRefreshing];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    float currentPostion = scrollView.contentOffset.y;
    BOOL  upDown = false;
    if (currentPostion - startY > 0 ||startY - currentPostion > 0) {
        startY = currentPostion;
        upDown=YES;
    }else{
        float index =scrollView.contentOffset.x/LSMainScreenW;
        if (isScroll&&!upDown) {
            [self.topTabView tabIndex:index];
//            if (index==1&&!_writtenModel) {
//                [self.writtenTabView headerBeginRefreshing];
//            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScroll =YES;
    if (scrollView.contentOffset.y>0) {
        isScroll =NO;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    isScroll =NO;
}

-(LsNavTabView *)topTabView{
    if (!_topTabView) {
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-100, 20+7, 200, 30)];
        _topTabView.dataArray =@[@"备考干货",@"考试公告"];
        _topTabView.delegate=self;
    }
    return _topTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+10*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame)-10*LSScale)];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, self.scrView.frame.size.height)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
//        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =LSColor(243, 244, 245, 1);
        //增加上拉下拉刷新事件
//        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
//        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(LsDataModel *)model{
    if (!_model) {
        _model =[[LsDataModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
