//
//  LsGuidePageViewController.m
//  lss
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsGuidePageViewController.h"
#import "LsLoginViewController.h"

@interface LsGuidePageViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scroll;
    UIPageControl *page;
}
@end

@implementation LsGuidePageViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadGuidePage];
    // Do any additional setup after loading the view.
}


-(void)loadGuidePage{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    scroll.backgroundColor=[UIColor whiteColor];
    
    //隐藏滚动条
    [scroll setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:scroll];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    image1.image=[UIImage imageNamed:@"juanzi"];
    [scroll addSubview:image1];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    image2.image=[UIImage imageNamed:@"heiban"];
    [scroll addSubview:image2];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height)];
    image3.image=[UIImage imageNamed:@"deng"];
    [scroll addSubview:image3];
    
//    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    image4.image=[UIImage imageNamed:@"引导4"];
//    [scroll addSubview:image4];
    
    
    //设置可滑动区域
    scroll.contentSize=CGSizeMake(CGRectGetMaxX(image3.frame), 0);
    
    
//    page=[[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height-60, 60, 37)];
//    page.numberOfPages=3;
//    page.currentPage=0;
//    //    page.backgroundColor=[UIColor redColor];
//    [page addTarget:self action:@selector(tapPage:) forControlEvents:UIControlEventTouchUpInside];
//    //当前小点的颜色
//    page.currentPageIndicatorTintColor = [UIColor whiteColor];
//    //    page.selected = YES;
//    page.enabled=YES;
//    //其他小点的颜色
//    page.pageIndicatorTintColor = LSColor(220, 220, 220,1);
//    [self.view addSubview:page];
//
//    UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3+CGRectGetMaxX(page.frame)+20,CGRectGetMinY(page.frame)-14,85,50)];
//    image5.image=[UIImage imageNamed:@"开始体验"];
//    [scroll addSubview:image5];
//    UIButton*beginBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3+CGRectGetMaxX(page.frame)+20,CGRectGetMinY(page.frame)-14,85,50)];
//    [beginBtn addTarget:self action:@selector(nextstep) forControlEvents:UIControlEventTouchUpInside];
//    [scroll addSubview:beginBtn];
//
//
//    UIButton*closebt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 20, 70, 40)];
//    [closebt addTarget:self action:@selector(nextstep) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:closebt];
//    [self.view bringSubviewToFront:closebt];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)nextstep{
    LsLog(@"跳过，直接进入了...");
    LsLoginViewController *loginVc = [[LsLoginViewController alloc] init];
    loginVc.modalPresentationStyle =UIModalPresentationCustom;
    loginVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;//渐隐渐现
    [LSUser_Default setObject:@"yes" forKey:@"didGuide"];
    [self presentViewController:loginVc animated:YES completion:nil];
}

-(void)tapPage:(UIPageControl *)sender{
    LsLog(@"点小点了..%ld.",(long)sender.currentPage);
    
    scroll.contentOffset=CGPointMake(sender.currentPage*self.view.frame.size.width, 0) ;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    page.currentPage=scrollView.contentOffset.x/self.view.frame.size.width;
    if (scrollView.contentOffset.x>self.view.frame.size.width*2+50) {
        LsLog(@"进去吧");
        
        [self nextstep];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
