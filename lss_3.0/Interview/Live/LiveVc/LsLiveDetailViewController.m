//
//  LsLiveDetailViewController.m
//  lss
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailViewController.h"
#import "LsLiveDetailModel.h"

@interface LsLiveDetailViewController ()

@end

@implementation LsLiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"课程详情";
    [self loadBaseUI];
    [self getData];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"top_background"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, topImage.size.height)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    
    [superView bringSubviewToFront:self.navView];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"listcourse.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
