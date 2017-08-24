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
    [IQKeyboardManager sharedManager].enable = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    superView =self.view;
    [[[UIApplication sharedApplication].delegate window] addSubview:self.navView];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.navView.leftButton addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
