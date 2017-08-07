//
//  LsLiveBroadcastViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsInterviewViewController.h"
#import "UCCarouselView.h"

@interface LsInterviewViewController ()

@property (nonatomic,strong)  NSArray *bannerArray;

@end

@implementation LsInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navView.navTitle =@"面试";
//    [self getUserInfo];
    [self initData];
    [self loadBaseUI];
}

-(void)getUserInfo{
    
//    channel：渠道号,必输
//    mobile:手机号,必输
//    password：密码,必输
//    password2：确认密码,必输
//    smscheckcode：短信验证码,必输
//    preregist.html  registuser.html
    
//    NSDictionary  *dict =@{@"mobile":@"17507120068",@"password":@"lzl123456",@"password2":@"lzl123456",@"smscheckcode":@"393868"};
    NSDictionary  *dict =@{@"mobile":@"17507120068"};
    [[LsAFNetWorkTool shareManger] LSGET:@"preregist.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        LsLog(@"----------成功-----%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        LsLog(@"----------成功-----%@",error);
    }];
}

-(void)initData{
    _bannerArray = @[LOADIMAGEWITHTYPE(@"banner1", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner2", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner3", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner4", @"jpg"),
                     LOADIMAGEWITHTYPE(@"banner5", @"jpg")];
}

-(void)loadBaseUI{
    [self loadCarouselViewWithTimer];
}

// 使用定时器初始化
- (void)loadCarouselViewWithTimer {

    UCCarouselView  *carouselView  =[[UCCarouselView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 140*LSScale)       dataArray:_bannerArray
                                                             timeInterval:2
                                                       didSelectItemBlock:^(NSInteger didSelectItem){
                                                           LsLog(@"--------------%d",didSelectItem);
    }];
    [superView addSubview:carouselView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
