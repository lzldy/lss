//
//  LsDataViewController.m
//  lss
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsDataViewController.h"
#import "LsNavTabView.h"

@interface LsDataViewController ()<lsNavTabViewDelegate,UIScrollViewDelegate>
{
    BOOL       isScroll;
    float      startY;

}
@property (nonatomic,strong) LsNavTabView *topTabView;
@property (nonatomic,strong) UIScrollView *scrView;

@end

@implementation LsDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"资料";
    [self.navView addSubview:self.topTabView];
    [superView addSubview:self.scrView];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135*LSScale;
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
    LsLiveModel *modelll =[[LsLiveModel alloc] init];
   
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
