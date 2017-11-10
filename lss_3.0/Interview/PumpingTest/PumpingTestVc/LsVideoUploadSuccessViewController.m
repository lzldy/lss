//
//  LsVideoUploadSuccessViewController.m
//  lss
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsVideoUploadSuccessViewController.h"
#import "LsShareModel.h"
#import <UShareUI/UShareUI.h>
#import <QuartzCore/QuartzCore.h>

@interface LsVideoUploadSuccessViewController ()
@property (nonatomic,strong)     LsShareModel *shareModel;

@end

@implementation LsVideoUploadSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"分享给老友";
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"uvs"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenW/topImage.size.width*topImage.size.height)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    
    [self.shareModel shareActionWithUrl:@"www.baidu.com" OnVc:self];
}

-(void)backBtn{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
