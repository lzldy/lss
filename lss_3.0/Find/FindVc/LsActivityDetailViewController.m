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

@end

@implementation LsActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle         =self.title_;
    superView.backgroundColor     =LSColor(243, 244, 245, 1);
    
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *bannerImage =[UIImage imageNamed:@"banner"];
    UIImageView *bannerView  =[[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, bannerImage.size.height/bannerImage.size.width*LSMainScreenW)];
    bannerView.image         =bannerImage;
    [superView addSubview:bannerView];
    
    UIView  *headerView      =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.frame)+10*LSScale, LSMainScreenW, 45*LSScale)];
    headerView.backgroundColor =[UIColor whiteColor];
    [superView addSubview:headerView];
    
    
    
    UIButton *submitBtn      =[[UIButton alloc] initWithFrame:CGRectMake(0, LSMainScreenH-45*LSScale, LSMainScreenW, 45*LSScale)];
    [submitBtn setTitle:@"预约报名" forState:0];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:0];
    submitBtn.backgroundColor  =LSNavColor;
    submitBtn.titleLabel.font  =[UIFont systemFontOfSize:15.5*LSScale];
    submitBtn.tag            =9098;
    [submitBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:submitBtn];

    
}

-(void)clickBtn:(UIButton *)btn{
    if (btn.tag ==9098) {
        LsOneToOneDetailViewController *vc =[[LsOneToOneDetailViewController alloc] init];
        vc.isActivity                      =YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
