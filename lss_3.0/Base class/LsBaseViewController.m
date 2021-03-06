//
//  LsBaseViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseViewController.h"

@interface LsBaseViewController ()

@end

@implementation LsBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (self.closeIQKeyBoard) {
        [IQKeyboardManager sharedManager].enable = NO;
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    if (self.hidesBottomBarWhenPushed==YES) {
        self.navView.leftButton.hidden=NO;
    }else{
        self.navView.leftButton.hidden=YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[[UIApplication sharedApplication].delegate window] addSubview:self.navView];
    [IQKeyboardManager sharedManager].enable = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    superView =self.view;
    [superView addSubview:self.navView];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.navView.leftButton addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgImageView   =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
    self.bgImageView.image  =LOADIMAGE(@"hnr_icon");
    self.bgImageView.hidden =YES;
    [superView addSubview:self.bgImageView];
}

-(void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(LsNavView *)navView{
    if (!_navView) {
        _navView =[[LsNavView alloc] init];
    }
    return _navView;
}

- (BOOL)shouldAutorotate
{
    return false;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
