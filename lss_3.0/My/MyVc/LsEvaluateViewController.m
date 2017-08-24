//
//  LsEvaluateViewController.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsEvaluateViewController.h"

@interface LsEvaluateViewController ()

@end

@implementation LsEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"评价";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIView *backgroundView         =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 90*LSScale)];
    backgroundView.backgroundColor =LSNavColor;
    [superView addSubview:backgroundView];
    
    UIView  *headerView            =[[UIView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMidY(backgroundView.frame), LSMainScreenW-20*LSScale, 140*LSScale)];
    headerView.backgroundColor     =[UIColor whiteColor];
    headerView.layer.cornerRadius  =6;
    [superView addSubview:headerView];
    
    UIView  *midView               =[[UIView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(headerView.frame)+10*LSScale, LSMainScreenW-20*LSScale, 190*LSScale)];
    midView.backgroundColor        =[UIColor whiteColor];
    midView.layer.cornerRadius     =6;
    [superView addSubview:midView];
    
    UIButton  *submitBtn           =[[UIButton alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(midView.frame)+20*LSScale, LSMainScreenW-20*LSScale, 36*LSScale)];
    submitBtn.layer.cornerRadius   =18*LSScale;
    submitBtn.layer.backgroundColor=LSNavColor.CGColor;
    [submitBtn setTitle:@"立即提交" forState:0];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:0];
    [submitBtn addTarget:self action:@selector(didcClickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:submitBtn];
}

-(void)didcClickSubmitBtn{
    [LsMethod alertMessage:@"立即提交" WithTime:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
