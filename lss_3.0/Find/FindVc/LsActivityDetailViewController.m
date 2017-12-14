//
//  LsActivityDetailViewController.m
//  lss
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsActivityDetailViewController.h"
#import "LsOneToOneDetailViewController.h"

@interface LsActivityDetailViewController ()
{
    UIView   *headerView;
    UIButton *introduceBtn;
    UIButton *guaranteeBtn;
}
@property (nonatomic,strong) UIScrollView *scrView;
//@property (nonatomic,strong) UIScrollView *scrView1;

@end

@implementation LsActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle         =self.title_;
    superView.backgroundColor     =LSColor(243, 244, 245, 1);
    
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *bannerImage   =[UIImage imageNamed:@"banner"];
    UIImageView *bannerView    =[[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, bannerImage.size.height/bannerImage.size.width*LSMainScreenW)];
    [bannerView sd_setImageWithURL:self.headUrl placeholderImage:bannerImage];
    [superView addSubview:bannerView];
    
    headerView        =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.frame)+10*LSScale, LSMainScreenW, 45*LSScale)];
    headerView.backgroundColor =[UIColor whiteColor];
    [superView addSubview:headerView];
    
    introduceBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/4-45*LSScale,10*LSScale, 90*LSScale, 25*LSScale)];
    introduceBtn.frame  =CGRectMake(15*LSScale, 10*LSScale, 90*LSScale, 25*LSScale);
    [introduceBtn setImage:[UIImage imageNamed:@"details_button_after"] forState:UIControlStateNormal];
//    [introduceBtn setImage:[UIImage imageNamed:@"details_button_after"] forState:UIControlStateSelected];
    [introduceBtn setTitle:@"课程介绍" forState:UIControlStateNormal];
    introduceBtn.titleLabel.font   =[UIFont systemFontOfSize:14*LSScale];
    [introduceBtn setTitleColor:LSNavColor forState:UIControlStateNormal];
//    [introduceBtn setTitleColor:LSNavColor forState:UIControlStateSelected];
//    introduceBtn.selected =YES;
    introduceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [introduceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0.0,0.0)];
//    [introduceBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    introduceBtn.tag=123;
    [headerView addSubview:introduceBtn];
    
//    UIView *midLine  =[[UIView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-0.25*LSScale, 10*LSScale, 0.5*LSScale, 25*LSScale)];
//    midLine.backgroundColor  =LSLineColor;
//    [headerView addSubview:midLine];
//
//    guaranteeBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/4*3-45*LSScale, 10*LSScale, 90*LSScale, 25*LSScale)];
//    [guaranteeBtn setImage:[UIImage imageNamed:@"kcjs_buttong_before"] forState:UIControlStateNormal];
//    [guaranteeBtn setImage:[UIImage imageNamed:@"kcjs_buttong_after"] forState:UIControlStateSelected];
//    [guaranteeBtn setTitle:@"服务保障" forState:UIControlStateNormal];
//    guaranteeBtn.titleLabel.font   =[UIFont systemFontOfSize:14*LSScale];
//    [guaranteeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [guaranteeBtn setTitleColor:LSNavColor forState:UIControlStateSelected];
//    guaranteeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [guaranteeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0.0,0.0)];
//    [guaranteeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    guaranteeBtn.tag=1234;
//    [headerView addSubview:guaranteeBtn];
    
//    [superView addSubview:self.scrView1];
    [superView addSubview:self.scrView];
    
    UIImageView  *introduceImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrView.frame.size.width, self.scrView.frame.size.height)];
    introduceImageView.contentMode   =UIViewContentModeScaleAspectFit;
    [introduceImageView sd_setImageWithURL:self.iconUrl placeholderImage:bannerImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [self.scrView setContentSize:CGSizeMake(LSMainScreenW, image.size.height)];
    }];
    [self.scrView addSubview:introduceImageView];
//
//    [introduceImageView sd_setImageWithURL:self.iconUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [self.scrView setContentSize:CGSizeMake(LSMainScreenW, image.size.height)];
//    }];
    
    UIButton *submitBtn        =[[UIButton alloc] initWithFrame:CGRectMake(0, LSMainScreenH-45*LSScale, LSMainScreenW, 45*LSScale)];
    submitBtn.backgroundColor  =LSNavColor;
    submitBtn.titleLabel.font  =[UIFont systemFontOfSize:15.5*LSScale];
    submitBtn.tag              =9098;
    [submitBtn setTitle:@"预约报名" forState:0];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:0];
    [submitBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:submitBtn];
}

-(void)clickBtn:(UIButton *)btn{
    if (btn.tag ==9098) {
        LsOneToOneDetailViewController *vc =[[LsOneToOneDetailViewController alloc] init];
        vc.isActivity                      =YES;
        vc.ID                              =self.id_;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
//        if (btn.tag==123) {
//            guaranteeBtn.selected =NO;
//            introduceBtn.selected =YES;
//
//            self.scrView.hidden   =NO;
//            self.scrView1.hidden  =YES;
//            [superView bringSubviewToFront:self.scrView];
//            [self.scrView.layer addAnimation:[LsMethod opacityAnimationFormValue:0 ToValue:1] forKey:nil];
//        }else{
//            introduceBtn.selected=NO;
//            guaranteeBtn.selected=YES;
//
//            self.scrView1.hidden   =NO;
//            self.scrView.hidden    =YES;
//            [superView bringSubviewToFront:self.scrView1];
//            [self.scrView1.layer addAnimation:[LsMethod opacityAnimationFormValue:0 ToValue:1] forKey:nil];
//        }
    }
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame)+5*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(headerView.frame)-5*LSScale-45*LSScale)];
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.showsVerticalScrollIndicator     =NO;
        _scrView.backgroundColor                  =[UIColor clearColor];
    }
    return _scrView;
}

//-(UIScrollView *)scrView1{
//    if (!_scrView1) {
//        _scrView1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame)+5*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(headerView.frame)-5*LSScale-45*LSScale)];
//        _scrView1.showsHorizontalScrollIndicator   =NO;
//        _scrView1.showsVerticalScrollIndicator     =NO;
//        _scrView1.backgroundColor                  =[UIColor greenColor];
//    }
//    return _scrView1;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
