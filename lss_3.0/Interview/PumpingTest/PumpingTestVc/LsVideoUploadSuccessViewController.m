//
//  LsVideoUploadSuccessViewController.m
//  lss
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsVideoUploadSuccessViewController.h"
#import "LsShareModel.h"
@interface LsVideoUploadSuccessViewController ()
{
    LsShareModel *shareModel;
}
@end

@implementation LsVideoUploadSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"uvs"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW, topImage.size.width*LSMainScreenH/LSMainScreenW)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    
    [shareModel shareActionWithImage:topImage];//这里要改
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
