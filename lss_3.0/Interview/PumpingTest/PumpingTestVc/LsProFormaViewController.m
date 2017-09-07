//
//  LsProFormaViewController.m
//  lss
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsProFormaViewController.h"

@interface LsProFormaViewController ()
{
    UIButton     *startBtn;
}
@end

@implementation LsProFormaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle      =@"开始备考";
    superView.backgroundColor  =LSColor(251, 243, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *image      =[UIImage imageNamed:@"test_back"];
    UIImageView *backImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW,LSMainScreenW/image.size.width*image.size.height)];
    backImageV.image        =image;
    [superView addSubview:backImageV];
    [superView bringSubviewToFront:self.navView];
    
    UIView  *midView        =[[UIView alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(self.navView.frame)+80*LSScale, LSMainScreenW-30*LSScale, 250*LSScale)];
    midView.layer.cornerRadius =10*LSScale;
    midView.backgroundColor =[UIColor whiteColor];
    [superView addSubview:midView];
    
    startBtn         =[[UIButton alloc] initWithFrame:CGRectMake(15*LSScale, LSMainScreenH-38*LSScale-20*LSScale, LSMainScreenW-30*LSScale, 38*LSScale)];
    startBtn.layer.backgroundColor =LSNavColor.CGColor;
    startBtn.layer.cornerRadius    =6*LSScale;
    [startBtn setTitle:@"开始考试" forState:0];
    [startBtn setTitleColor:[UIColor whiteColor] forState:0];
    startBtn.titleLabel.font       =[UIFont systemFontOfSize:15*LSScale];
    [startBtn addTarget:self action:@selector(didClickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:startBtn];
    
}

-(void)didClickStartBtn:(UIButton*)btn{
    [LsMethod alertMessage:@"开始录视频" WithTime:1.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
