//
//  LsProFormaViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsProFormaViewController.h"

@interface LsProFormaViewController ()

@end

@implementation LsProFormaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor yellowColor];
    NSDictionary  * dict =@{@"name":@"客户端",@"adress":@"惊世毒妃拉克的手机卡",@"gh":@"哈看的经适房哈师大"};
    LsLog(@"------%@-------%@",BASE_URL,dict);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
