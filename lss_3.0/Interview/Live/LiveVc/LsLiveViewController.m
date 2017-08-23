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
#import "LsLiveDetailViewController.h"
#import "LsLiveModel.h"
#import "LsMyLiveListViewController.h"

@interface LsLiveViewController ()<lsNavTabViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  indexTabView;
    BOOL       isScroll;
    float      startY;
}
@property (nonatomic,strong) LsNavTabView *topTabView;
@property (nonatomic,strong) UIScrollView *scrView;
@property (nonatomic,strong) UITableView  *interviewTabView;//面试
@property (nonatomic,strong) UITableView  *writtenTabView;//笔试
@property (nonatomic,strong) LsLiveModel  *interviewModel;
@property (nonatomic,strong) LsLiveModel  *writtenModel;

@end

@implementation LsLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"直播";
    [self.navView addSubview:self.topTabView];
    [self loadBaseUI];
    [self.interviewTabView headerBeginRefreshing];

}

-(void)getInterviewData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"listinterviewcourse.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
//        _interviewModel =[LsLiveModel yy_modelWithDictionary:responseObject];
        NSArray *array =[[responseObject objectForKey:@"data"] objectForKey:@"interview"];
        NSDictionary  *dict =@{@"data":array};
        _interviewModel =[LsLiveModel yy_modelWithDictionary:dict];

        [self.interviewTabView headerEndRefreshing];
        [self.interviewTabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)getWrittenData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"listwrittencourse.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
//        _writtenModel =[LsLiveModel yy_modelWithDictionary:responseObject];
        
        NSArray *array =[[responseObject objectForKey:@"data"] objectForKey:@"written"];
        NSDictionary  *dict =@{@"data":array};
        _writtenModel =[LsLiveModel yy_modelWithDictionary:dict];
        
        [self.writtenTabView headerEndRefreshing];
        [self.writtenTabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)loadBaseUI{
    [superView addSubview:self.scrView];
    [self.scrView addSubview:self.interviewTabView];
    [self.scrView addSubview:self.writtenTabView];
    
    UIButton *myLive =[[UIButton alloc] initWithFrame:CGRectMake(0, LSMainScreenH-50, LSMainScreenW, 50)];
    [myLive setTitle:@"我的直播" forState:0];
    myLive.backgroundColor   =LSNavColor;
    [myLive addTarget:self action:@selector(clickMyLiveBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:myLive];
}

-(void)clickMyLiveBtn{
    LsMyLiveListViewController *myLiveVc=[[LsMyLiveListViewController alloc] init];
    [self.navigationController pushViewController:myLiveVc animated:YES];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag==10010) {
        return _interviewModel.liveArray.count;
    }else{
        return _writtenModel.liveArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsLiveModel *modelll =[[LsLiveModel alloc] init];
    if (tableView.tag==10010){
        modelll =self.interviewModel.liveArray[indexPath.row];
    }else{
        modelll =self.writtenModel.liveArray[indexPath.row];
    }
    [cell reloadCell:modelll Type:@"2"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsLiveModel *modelll =[[LsLiveModel alloc] init];
    if (tableView.tag==10010) {
        modelll =self.interviewModel.liveArray[indexPath.row];
    }else{
        modelll =self.writtenModel.liveArray[indexPath.row];
    }
    LsLiveDetailViewController *detailVc =[[LsLiveDetailViewController alloc] init];
    detailVc.classId                     =modelll.id_;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma - mark -    上下拉刷新
-(void)writtenTabViewHeaderRefresh{
    isScroll=NO;
    [self getWrittenData];
}

-(void)writtenTabViewFooterRefresh{
    isScroll=NO;

//    [self.writtenTabView reloadData];
    [self.writtenTabView footerEndRefreshing];
}

-(void)interviewTabViewHeaderRefresh{
    isScroll=NO;
    [self getInterviewData];
}

-(void)interviewTabViewFooterRefresh{
    isScroll=NO;

//    [self.interviewTabView reloadData];
    [self.interviewTabView footerEndRefreshing];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
        [self.interviewTabView headerBeginRefreshing];
    }else{
        [self.writtenTabView headerBeginRefreshing];
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
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
