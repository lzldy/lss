//
//  LsProFormaViewController.m
//  lss
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsProFormaViewController.h"
#import "LsVideotapeViewController.h"
#import "LsProFormaModel.h"
#import "JZAlbumViewController.h"

@interface LsProFormaViewController ()
{
    UIButton     *startBtn;
    UILabel      *titleL;
}
@property (nonatomic,strong) LsProFormaModel *model;

@end

@implementation LsProFormaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle      =@"开始备考";
    superView.backgroundColor  =LSColor(251, 243, 245, 1);
    
    [self loadBaseUI];
    [self getData];
}

-(void)getData{
    if (self.ctag1) {
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        [dict setObject:self.ctag1                               forKey:@"ctag1"];
        [dict setObject:[LSUser_Default objectForKey:@"catgid"]  forKey:@"catgid"];
        [dict setObject:[LSUser_Default objectForKey:@"scatgid"] forKey:@"scatgid"];
        
        [[LsAFNetWorkTool shareManger] LSPOST:@"listcoursefilebyram.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            self.model   =[LsProFormaModel yy_modelWithJSON:responseObject];
            titleL.text  =self.model.name;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        }];
    }else{
        LsLog(@"--------直接进入录制视频---------");
    }
}

-(void)loadBaseUI{
    UIImage     *image      =[UIImage imageNamed:@"test_back"];
    UIImageView *backImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW,LSMainScreenW/image.size.width*image.size.height)];
    backImageV.image        =image;
    [superView addSubview:backImageV];
    [superView bringSubviewToFront:self.navView];
    
    UIImage     *backImage          =[UIImage imageNamed:@"kp_bj"];
    UIImageView *backGroudImageView =[[UIImageView alloc] initWithFrame:CGRectMake(15*LSScale,  CGRectGetMaxY(self.navView.frame)+80*LSScale,LSMainScreenW-30*LSScale,(LSMainScreenW-30*LSScale)/backImage.size.width*backImage.size.height)];
    backGroudImageView.image        =backImage;
    [superView addSubview:backGroudImageView];
    
    UILabel   *label                =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 11*LSScale, 150*LSScale, 30*LSScale)];
    label.text                      =@"你本次说课的题目是：";
    label.textAlignment             =NSTextAlignmentLeft;
    label.textColor                 =[UIColor darkGrayColor];
    label.font                      =[UIFont systemFontOfSize:13*LSScale];
    [backGroudImageView addSubview:label];
    
    titleL                =[[UILabel alloc] initWithFrame:CGRectMake(20*LSScale,CGRectGetHeight(backGroudImageView.frame)/2+20*LSScale-50*LSScale,CGRectGetWidth(backGroudImageView.frame) -40*LSScale, 100*LSScale)];
    titleL.layer.cornerRadius        =8*LSScale;
    titleL.numberOfLines             =0;
    titleL.text                      =@"";
    titleL.textAlignment             =NSTextAlignmentCenter;
    titleL.textColor                 =[UIColor darkTextColor];
    titleL.font                      =[UIFont systemFontOfSize:18*LSScale];
    titleL.layer.backgroundColor     =LSColor(251, 243, 245, 1).CGColor;
    [backGroudImageView addSubview:titleL];
    
    UIButton    *imageBtn            =[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backGroudImageView.frame) +10*LSScale, LSMainScreenW, 30*LSScale)];
    [imageBtn setTitle:@"查看完成题目" forState:0];
    [imageBtn setTitleColor:LSNavColor forState:0];
    imageBtn.titleLabel.font         =[UIFont systemFontOfSize:14.5*LSScale];
    [imageBtn addTarget:self action:@selector(didClickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.tag    =812;
    [superView addSubview:imageBtn];
    
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
    if (btn.tag==812) {
        if (self.model.imageArray.count>0) {
            JZAlbumViewController *c = [JZAlbumViewController new];
            NSMutableArray *array = [NSMutableArray array];
            for(LsProFormaModel *modelll in self.model.imageArray) {
                [array addObject:modelll.imageUrl];
            }
            c.imgArr = array;
            c.currentIndex = 0;
            [self presentViewController:c animated:YES completion:nil];
        }else{
            [LsMethod alertMessage:@"暂无图片" WithTime:1.5];
        }
    }else{
        LsVideotapeViewController *vc =[[LsVideotapeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(LsProFormaModel *)model{
    if (!_model) {
        _model =[[LsProFormaModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
