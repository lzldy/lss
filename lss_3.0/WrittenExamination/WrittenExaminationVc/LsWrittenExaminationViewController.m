//
//  LsProFormaViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWrittenExaminationViewController.h"
#import "LsNavTabView.h"

@interface LsWrittenExaminationViewController ()<lsNavTabViewDelegate,UIScrollViewDelegate>
{
    BOOL       isScroll;
    float      startY;
    
}
@property (nonatomic,strong) LsNavTabView *topTabView;
@property (nonatomic,strong) UIScrollView *scrView;


@end

@implementation LsWrittenExaminationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.navTitle =@"笔试";
    [self.navView addSubview:self.topTabView];
    [superView addSubview:self.scrView];
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
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-75, 20+7, 150, 30)];
        _topTabView.dataArray =@[@"模考",@"考点"];
        _topTabView.delegate=self;
    }
    return _topTabView;
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
