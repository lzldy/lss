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
#import "LsWrittenTableViewCell.h"
#import "LsLiveTableViewCell.h"

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
@property (nonatomic,strong) UIScrollView *scrView1;

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
    [superView     addSubview:topImageV];
    [superView     bringSubviewToFront:self.navView];
    [superView     addSubview:self.headerView];
    [superView     addSubview:self.scrView];
    [self.scrView  addSubview:self.scrView1];
    [self.scrView1 addSubview:self.upTabView];
    [self.scrView1 addSubview:self.downTabView];
    [self.scrView1 setContentSize:CGSizeMake(LSMainScreenW*2, CGRectGetMaxY(self.downTabView.frame)+80*LSScale)];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
        LsLog(@"11111111111111");
    }else{
        LsLog(@"22222222222");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
        float currentPostion = scrollView.contentOffset.y;
        BOOL  upDown = false;
        if (currentPostion - startY > 35 ||startY - currentPostion > 35) {
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
    if (tableView.tag==100) {
        return 55*LSScale;
    }else if (tableView.tag==200){
        return 135*LSScale;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==100) {
        static NSString *cellID = @"upCellID";
        LsWrittenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[LsWrittenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        
        return cell;

    }else if (tableView.tag==200){
        static NSString *cellID = @"downCellID";
        LsLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[LsLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        LsLiveModel *modelll =[[LsLiveModel alloc] init];
                [cell reloadCell:modelll Type:@"2"];
        
        
        return cell;
    }
       return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView  *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 30*LSScale)];
    view.backgroundColor =[UIColor whiteColor];
    UILabel *titleL     =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 0, 200, 30*LSScale)];
    titleL.font         =[UIFont systemFontOfSize:13.5*LSScale];
    titleL.textAlignment=NSTextAlignmentLeft;
    [view addSubview:titleL];
    
    UIView  *line =[[UIView alloc] initWithFrame:CGRectMake(0, 30*LSScale-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
    line.backgroundColor =LSLineColor;
    [view addSubview:line];
    
    if (tableView.tag==100) {
        titleL.text         =@"针对性刷题";

    }else if(tableView.tag==200){
        titleL.text         =@"做题+听直播";

    }
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 30*LSScale)];
    UILabel *titleL     =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 0, 200, 30*LSScale)];
    titleL.font         =[UIFont systemFontOfSize:12*LSScale];
    titleL.textAlignment=NSTextAlignmentLeft;
    titleL.textColor    =LSNavColor;
    view.backgroundColor =[UIColor whiteColor];
    [view addSubview:titleL];

    if (tableView.tag==100) {
        titleL.text         =@"查看所有试卷";
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30*LSScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30*LSScale;
}

-(UITableView *)upTabView{
    if (!_upTabView) {
        _upTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW,55*LSScale*3+30*LSScale*2)];
        _upTabView.delegate         =self;
        _upTabView.dataSource       =self;
        _upTabView.showsVerticalScrollIndicator   =NO;
        _upTabView.scrollEnabled    =NO;
        _upTabView.tag              =100;
        _upTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _upTabView.backgroundColor  =[UIColor clearColor];
    }
    return _upTabView;
}

-(UITableView *)downTabView{
    if (!_downTabView) {
        _downTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.upTabView.frame)+10*LSScale, LSMainScreenW,30*LSScale+135*LSScale*3)];
        _downTabView.delegate         =self;
        _downTabView.dataSource       =self;
        _downTabView.showsVerticalScrollIndicator   =NO;
        _downTabView.scrollEnabled    =NO;
        _downTabView.tag              =200;
        _downTabView.tableFooterView  =[[UIView alloc] init];
        _downTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
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
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)+10*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.headerView.frame)-10*LSScale)];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.showsVerticalScrollIndicator     =NO;
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

-(UIScrollView *)scrView1{
    if (!_scrView1) {
        _scrView1=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.headerView.frame)-10*LSScale)];
        _scrView1.pagingEnabled                    =YES;
        _scrView1.contentSize                      =CGSizeMake(LSMainScreenW, 0);
        _scrView1.showsHorizontalScrollIndicator   =NO;
        _scrView1.showsVerticalScrollIndicator     =NO;
        _scrView1.delegate                         =self;
        _scrView1.bounces                          =NO;
    }
    return _scrView1;
}

-(LsWrittenHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[LsWrittenHeaderView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(self.navView.frame), LSMainScreenW-20*LSScale, 85*LSScale)];
        _headerView.dataDcit  =@{@"testPaper":@"6套",@"testQuestions":@"50",@"correctRate":@"88%"};
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
