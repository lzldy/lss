//
//  LsEnrollSuccessViewController.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsEnrollSuccessViewController.h"
#import <UShareUI/UShareUI.h>
#import "LsShareModel.h"

@interface LsEnrollSuccessViewController ()

@property (nonatomic,strong)      LsShareModel *shareModel;

@end

@implementation LsEnrollSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"报名成功";
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage *image          =[UIImage imageNamed:@"enrollbg"];
    UIImageView  *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, image.size.height/image.size.width*LSMainScreenW)];
    imageview.image         =image;
    [superView addSubview:imageview];
    
    UILabel    *titleL      =[[UILabel alloc] initWithFrame:CGRectMake(0, 30*LSScale+CGRectGetMaxY(self.navView.frame), LSMainScreenW, 50*LSScale)];
    titleL.text             =_model.title;
    titleL.textColor        =[UIColor whiteColor];
    titleL.textAlignment    =NSTextAlignmentCenter;
    titleL.backgroundColor  =[UIColor clearColor];
    titleL.font             =[UIFont boldSystemFontOfSize:23];
    [superView addSubview:titleL];
    
    UIButton  *shareBtn       =[[UIButton alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(imageview.frame)+35*LSScale, LSMainScreenW-60*LSScale, 40*LSScale)];
    shareBtn.backgroundColor  =LSColor(252, 48, 14, 1);
    [shareBtn setTitle:@"邀请闺蜜共同学习" forState:0];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:0];
    [shareBtn addTarget:self action:@selector(didClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:shareBtn];
   
    _model.isPackage =NO;
    if (!_model.isPackage) {
        UIButton * intoBtn=[[UIButton alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(imageview.frame)+35*LSScale, LSMainScreenW-60*LSScale, 40*LSScale)];
        intoBtn.backgroundColor  =LSNavColor;
        [intoBtn setTitle:@"进入直播间" forState:0];
        [intoBtn setTitleColor:[UIColor whiteColor] forState:0];
        [intoBtn addTarget:self action:@selector(didClickIntoBtn) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:intoBtn];
        
        shareBtn.frame =CGRectMake(30*LSScale, CGRectGetMaxY(intoBtn.frame)+12*LSScale, LSMainScreenW-60*LSScale, 40*LSScale);
    }
    
    UILabel  *bottomL  =[[UILabel alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(shareBtn.frame)+10*LSScale, LSMainScreenW-60*LSScale, 20*LSScale)];
    bottomL.textColor  =LSNavColor;
    bottomL.text       =@"注:您可以在“我报名的直播课”中进行查看";
    bottomL.textAlignment =NSTextAlignmentCenter;
    bottomL.font       =[UIFont systemFontOfSize:13*LSScale];
    [superView addSubview:bottomL];
        
}

-(void)didClickShareBtn{
//    [LsMethod alertMessage:@"分享" WithTime:2];
    [self.shareModel shareActionWithUrl:@"www.baidu.com" OnVc:self];
}

-(void)didClickIntoBtn{
    [LsMethod alertMessage:@"进入直播间" WithTime:2];
}

-(LsShareModel *)shareModel{
    if (!_shareModel) {
        _shareModel =[[LsShareModel alloc]init];
    }
    return _shareModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
