//
//  LsProFormaViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWrittenExaminationViewController.h"
#import "LsNavTabView.h"
#import "LsWrittenHeaderView.h"

@interface LsWrittenExaminationViewController ()<lsNavTabViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL       isScroll;
    float      startY;
    
}
@property (nonatomic,strong) LsNavTabView *topTabView;
@property (nonatomic,strong) UIScrollView *scrView;
@property (nonatomic,strong) LsWrittenHeaderView *headerView;
@property (nonatomic,strong) UITableView  *upTabView;
@property (nonatomic,strong) UITableView  *downTabView;

@end

@implementation LsWrittenExaminationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.navTitle     =@"笔试";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self.navView addSubview:self.topTabView];
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"top_background"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, topImage.size.height)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    [superView bringSubviewToFront:self.navView];
    
    [superView    addSubview:self.scrView];
    [self.scrView addSubview:self.headerView];
    [self.scrView addSubview:self.upTabView];

}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
        LsLog(@"11111111111111");
        //        [self.interviewTabView headerBeginRefreshing];
    }else{
        LsLog(@"22222222222");
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

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 28*LSScale)];
    view.backgroundColor  =[UIColor redColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 28*LSScale)];
    view.backgroundColor  =[UIColor greenColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28*LSScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 28*LSScale;
}

-(UITableView *)upTabView{
    if (!_upTabView) {
        _upTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headerView.frame)+10*LSScale, LSMainScreenW,55*LSScale*3+28*LSScale*2)];
        _upTabView.delegate         =self;
        _upTabView.dataSource       =self;
        _upTabView.showsVerticalScrollIndicator   =NO;
        _upTabView.scrollEnabled    =NO;
//        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _upTabView.backgroundColor  =[UIColor clearColor];
    }
    return _upTabView;
}

-(UITableView *)downTabView{
    if (!_downTabView) {
        _downTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.upTabView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.headerView.frame)-10*LSScale)];
        _downTabView.delegate         =self;
        _downTabView.dataSource       =self;
        _downTabView.showsVerticalScrollIndicator   =NO;
        _downTabView.scrollEnabled    =NO;
        //        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _downTabView.backgroundColor  =[UIColor clearColor];
    }
    return _downTabView;
}

-(LsNavTabView *)topTabView{
    if (!_topTabView) {
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-75, 20+7, 150, 30)];
        _topTabView.dataArray =@[@"模考",@"考点"];
        _topTabView.delegate=self;
    }
    return _topTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame),LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.headerView.frame)-15)];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

-(LsWrittenHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[LsWrittenHeaderView alloc] initWithFrame:CGRectMake(10*LSScale, 0, LSMainScreenW-20*LSScale, 85*LSScale)];
        _headerView.dataDcit  =@{@"testPaper":@"6套",@"testQuestions":@"50",@"correctRate":@"88%"};
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
