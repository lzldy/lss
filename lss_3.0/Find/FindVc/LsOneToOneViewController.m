//
//  LsOneToOneViewController.m
//  lss
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsOneToOneViewController.h"
#import "LsOneToOneDetailViewController.h"
#import "LsActivityModel.h"

@interface LsOneToOneViewController ()

@property (nonatomic,strong) UIScrollView    *scrView;
@property (nonatomic,strong) LsActivityModel *model;

@end

@implementation LsOneToOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle     =@"一对一课程";

    [superView addSubview:self.scrView];
    [self loadBaseUI];
//    [self getData];
}

//-(void)getData{
//    NSDictionary *dict =@{@"catg3":@"YDY"};
//    [[LsAFNetWorkTool shareManger] LSPOST:@"findcampaign.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
//        self.model  =[LsActivityModel yy_modelWithJSON:responseObject];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
//    }];
//}

-(void)loadBaseUI{
    
    UIView *bottomView       =[[UIView alloc] initWithFrame:CGRectMake(0, LSMainScreenH-110*LSScale, LSMainScreenW, 110*LSScale)];
    bottomView.backgroundColor  =LSNavColor;
    [superView addSubview:bottomView];
    
    UILabel  *label          =[[UILabel alloc] initWithFrame:CGRectMake(0, 25*LSScale, LSMainScreenW, 30*LSScale)];
    label.text               =@"良师承诺:一对一招考职位全国范围1:1等额招生";
    label.textColor          =[UIColor whiteColor];
    label.font               =[UIFont systemFontOfSize:13*LSScale];
    label.textAlignment      =NSTextAlignmentCenter;
    [bottomView addSubview:label];
    
    UIButton *yuyueBtn       =[[UIButton alloc] initWithFrame:CGRectMake(80*LSScale,CGRectGetMaxY(label.frame), LSMainScreenW-160*LSScale, 40*LSScale)];
    [yuyueBtn setImage:[UIImage imageNamed:@"yyue"] forState:0];
    [yuyueBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:yuyueBtn];
    
    UIImage     *bannerImage =[UIImage imageNamed:@"组-3"];
    UIImageView *bannerView  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, bannerImage.size.height/bannerImage.size.width*LSMainScreenW)];
    bannerView.image         =bannerImage;
    [self.scrView addSubview:bannerView];
    
    UIImage     *image1 =[UIImage imageNamed:@"fudao"];
    UIImageView *imageView1  =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.frame), LSMainScreenW, image1.size.height/image1.size.width*LSMainScreenW)];
    imageView1.image         =image1;
    [self.scrView addSubview:imageView1];
    
    UIImage     *image2 =[UIImage imageNamed:@"fw"];
    UIImageView *imageView2  =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), LSMainScreenW, image2.size.height/image2.size.width*LSMainScreenW)];
    imageView2.image         =image2;
    [self.scrView addSubview:imageView2];

    UIImage     *image3 =[UIImage imageNamed:@"qs"];
    UIImageView *imageView3  =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView2.frame), LSMainScreenW, image3.size.height/image3.size.width*LSMainScreenW)];
    imageView3.image         =image3;
    [self.scrView addSubview:imageView3];

    UIImage     *image4 =[UIImage imageNamed:@"xy"];
    UIImageView *imageView4  =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView3.frame), LSMainScreenW, image4.size.height/image4.size.width*LSMainScreenW)];
    imageView4.image         =image4;
    [self.scrView addSubview:imageView4];
    
    UIButton  *kefuBtn       =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-60*LSScale-15*LSScale, LSMainScreenH-140*LSScale, 60*LSScale, 60*LSScale)];
    [kefuBtn setImage:[UIImage imageNamed:@"find_kf"] forState:0];
    [kefuBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    kefuBtn.tag              =8099;
    [superView addSubview:kefuBtn];
    
    
    [self.scrView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(imageView4.frame))];
    
}

-(void)clickBtn:(UIButton*)button{
    if (button.tag==8099) {
        [LSApplication openURL:LSCustomerService];
    }else{
        LsOneToOneDetailViewController *vc =[[LsOneToOneDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame),LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame)-110*LSScale)];
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.showsVerticalScrollIndicator     =NO;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
    }
    return _scrView;
}

-(LsActivityModel *)model{
    if (!_model) {
        _model  =[[LsActivityModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
