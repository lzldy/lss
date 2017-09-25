//
//  LsRecordingCompletedViewController.m
//  lss
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsRecordingCompletedViewController.h"
#import "LSLabel+TextField.h"
#import "LsVideoUploadSuccessViewController.h"

@interface LsRecordingCompletedViewController ()<UITextFieldDelegate>
{
    UIButton    *shijiangBtn;
    UIButton    *shuokeBtn;
    UIButton    *dabianBtn;
    UIButton    *jiegouhuaBtn;
    UIButton    *chooseImageBtn;
}

@end

@implementation LsRecordingCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"视频上传";
    self.view.backgroundColor   =LSColor(243, 244, 245, 1);

    [self loadBaseUI];

}

-(void)loadBaseUI{
    UIImageView *videoImgView      =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 150*LSScale)];
    videoImgView.backgroundColor   =[UIColor whiteColor];
    videoImgView.image             = [LsMethod thumbnailImageForVideo:_videoURL atTime:1];
    videoImgView.contentMode       =UIViewContentModeScaleAspectFit;
    [superView addSubview:videoImgView];
    
    LSLabel_TextField  *titleL     =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(videoImgView.frame)+10*LSScale, LSMainScreenW,35*LSScale)];
    titleL.textField.delegate      =self;
    titleL.label.textColor         =[UIColor darkGrayColor];
    titleL.dataArray               =@[@"标题：",@""];
    [superView addSubview:titleL];
    
    UIView  *backgourdView         =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+10*LSScale, LSMainScreenW, 100)];
    backgourdView.backgroundColor  =[UIColor whiteColor];
    [superView addSubview:backgourdView];

    UILabel  *chooseTitleL         =[[UILabel alloc] initWithFrame:CGRectMake(15, 0, LSMainScreenW, 30)];
    chooseTitleL.text              =@"选择自己的标签";
    chooseTitleL.font              =[UIFont systemFontOfSize:11*LSScale];
    chooseTitleL.textColor         =[UIColor darkGrayColor];
    [backgourdView  addSubview:chooseTitleL];

    shijiangBtn                    =[[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(chooseTitleL.frame)+10, 48*LSScale, 20*LSScale)];
    [shijiangBtn setTitle:@"试讲" forState:0];
    [shijiangBtn setTitleColor:LSNavColor forState:0];
    shijiangBtn.titleLabel.font    =[UIFont systemFontOfSize:13*LSScale];
    shijiangBtn.layer.cornerRadius =8*LSScale;
    shijiangBtn.layer.borderWidth  =1;
    shijiangBtn.layer.borderColor  =LSNavColor.CGColor;
    shijiangBtn.tag                =111;
    [shijiangBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgourdView addSubview:shijiangBtn];
    
    shuokeBtn                    =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shijiangBtn.frame)+10*LSScale, CGRectGetMaxY(chooseTitleL.frame)+10, 48*LSScale, 20*LSScale)];
    [shuokeBtn setTitle:@"说课" forState:0];
    [shuokeBtn setTitleColor:LSNavColor forState:0];
    shuokeBtn.titleLabel.font    =[UIFont systemFontOfSize:13*LSScale];
    shuokeBtn.layer.cornerRadius =8*LSScale;
    shuokeBtn.layer.borderWidth  =1;
    shuokeBtn.layer.borderColor  =LSNavColor.CGColor;
    shuokeBtn.tag                =112;
    [shuokeBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgourdView addSubview:shuokeBtn];
    
    dabianBtn                    =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuokeBtn.frame)+10*LSScale, CGRectGetMaxY(chooseTitleL.frame)+10, 48*LSScale, 20*LSScale)];
    [dabianBtn setTitle:@"答辩" forState:0];
    [dabianBtn setTitleColor:LSNavColor forState:0];
    dabianBtn.titleLabel.font    =[UIFont systemFontOfSize:13*LSScale];
    dabianBtn.layer.cornerRadius =8*LSScale;
    dabianBtn.layer.borderWidth  =1;
    dabianBtn.layer.borderColor  =LSNavColor.CGColor;
    dabianBtn.tag                =113;
    [dabianBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgourdView addSubview:dabianBtn];
    
    jiegouhuaBtn                    =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dabianBtn.frame)+10*LSScale, CGRectGetMaxY(chooseTitleL.frame)+10, 55*LSScale, 20*LSScale)];
    [jiegouhuaBtn setTitle:@"结构化" forState:0];
    [jiegouhuaBtn setTitleColor:LSNavColor forState:0];
    jiegouhuaBtn.titleLabel.font    =[UIFont systemFontOfSize:13*LSScale];
    jiegouhuaBtn.layer.cornerRadius =8*LSScale;
    jiegouhuaBtn.layer.borderWidth  =1;
    jiegouhuaBtn.layer.borderColor  =LSNavColor.CGColor;
    jiegouhuaBtn.tag                =114;
    [jiegouhuaBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgourdView addSubview:jiegouhuaBtn];
    
    UILabel  *xiangmuL              =[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(shijiangBtn.frame)+10*LSScale, 72*LSScale, 18*LSScale)];
    xiangmuL.text                   =@"教师招聘";
    xiangmuL.layer.cornerRadius     =6*LSScale;
    xiangmuL.layer.backgroundColor  =LSColor(101, 102, 103, 1).CGColor;
    xiangmuL.textColor              =[UIColor whiteColor];
    xiangmuL.font                   =[UIFont systemFontOfSize:12.5*LSScale];
    xiangmuL.textAlignment          =NSTextAlignmentCenter;
    [backgourdView addSubview:xiangmuL];
    
    UILabel  *xueduanL              =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale+CGRectGetMaxX(xiangmuL.frame), CGRectGetMaxY(shijiangBtn.frame)+10*LSScale, 50*LSScale, 18*LSScale)];
    xueduanL.text                   =@"高中";
    xueduanL.layer.cornerRadius     =6*LSScale;
    xueduanL.layer.backgroundColor  =LSColor(101, 102, 103, 1).CGColor;
    xueduanL.textColor              =[UIColor whiteColor];
    xueduanL.font                   =[UIFont systemFontOfSize:12.5*LSScale];
    xueduanL.textAlignment          =NSTextAlignmentCenter;
    [backgourdView addSubview:xueduanL];
    
    UILabel  *kemuL                 =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale+CGRectGetMaxX(xueduanL.frame), CGRectGetMaxY(shijiangBtn.frame)+10*LSScale, 50*LSScale, 18*LSScale)];
    kemuL.text                     =@"语文";
    kemuL.layer.cornerRadius       =6*LSScale;
    kemuL.layer.backgroundColor    =LSColor(101, 102, 103, 1).CGColor;
    kemuL.textColor                =[UIColor whiteColor];
    kemuL.font                     =[UIFont systemFontOfSize:12.5*LSScale];
    kemuL.textAlignment            =NSTextAlignmentCenter;
    [backgourdView addSubview:kemuL];
    
    UIImage  *image                =[UIImage imageNamed:@"xuan"];
    chooseImageBtn                 =[[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(xiangmuL.frame)+10*LSScale,30*LSScale,30*LSScale)];
    [chooseImageBtn setImage:image forState:0];
    chooseImageBtn.tag             =115;
    [chooseImageBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backgourdView addSubview:chooseImageBtn];
    
    UILabel *textL                 =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(chooseImageBtn.frame), CGRectGetMaxY(xiangmuL.frame)+10*LSScale,LSMainScreenW,30*LSScale)];
    textL.text                     =@"仅推荐给名师";
    textL.textAlignment            =NSTextAlignmentLeft;
    textL.font                     =[UIFont systemFontOfSize:13*LSScale];
    textL.textColor                =LSNavColor;
    [backgourdView addSubview:textL];
    
    backgourdView.frame            =CGRectMake(0, backgourdView.frame.origin.y, backgourdView.frame.size.width, CGRectGetMaxY(chooseImageBtn.frame)+20*LSScale);
    
    UIButton  *uploadBtn           =[[UIButton alloc] initWithFrame:CGRectMake(20*LSScale, LSMainScreenH-30*LSScale-40*LSScale, LSMainScreenW-40*LSScale, 40*LSScale)];
    [uploadBtn setTitle:@"上传视频" forState:0];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:0];
    uploadBtn.layer.cornerRadius   =10*LSScale;
    uploadBtn.layer.backgroundColor=LSNavColor.CGColor;
    [uploadBtn addTarget:self action:@selector(didClickUploadBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:uploadBtn];
}

-(void)didClickUploadBtn{
    LsVideoUploadSuccessViewController *vc =[[LsVideoUploadSuccessViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickTypeBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 111:
        {
            [shijiangBtn   setTitleColor:[UIColor whiteColor] forState:0];
            shijiangBtn.layer.backgroundColor  =LSNavColor.CGColor;
            [shuokeBtn     setTitleColor:LSNavColor forState:0];
            shuokeBtn.layer.backgroundColor    =[UIColor whiteColor].CGColor;
            [dabianBtn     setTitleColor:LSNavColor forState:0];
            dabianBtn.layer.backgroundColor    =[UIColor whiteColor].CGColor;
            [jiegouhuaBtn  setTitleColor:LSNavColor forState:0];
            jiegouhuaBtn.layer.backgroundColor =[UIColor whiteColor].CGColor;
        }
            break;
        case 112:
        {
            [shijiangBtn   setTitleColor:LSNavColor forState:0];
            shijiangBtn.layer.backgroundColor  =[UIColor whiteColor].CGColor;
            [shuokeBtn     setTitleColor:[UIColor whiteColor] forState:0];
            shuokeBtn.layer.backgroundColor    =LSNavColor.CGColor;
            [dabianBtn     setTitleColor:LSNavColor forState:0];
            dabianBtn.layer.backgroundColor    =[UIColor whiteColor].CGColor;
            [jiegouhuaBtn  setTitleColor:LSNavColor forState:0];
            jiegouhuaBtn.layer.backgroundColor =[UIColor whiteColor].CGColor;
        }
            break;
        case 113:
        {
            [shijiangBtn  setTitleColor:LSNavColor forState:0];
            shijiangBtn.layer.backgroundColor  =[UIColor whiteColor].CGColor;
            [shuokeBtn    setTitleColor:LSNavColor forState:0];
            shuokeBtn.layer.backgroundColor    =[UIColor whiteColor].CGColor;
            [dabianBtn    setTitleColor:[UIColor whiteColor] forState:0];
            dabianBtn.layer.backgroundColor    =LSNavColor.CGColor;
            [jiegouhuaBtn setTitleColor:LSNavColor forState:0];
            jiegouhuaBtn.layer.backgroundColor =[UIColor whiteColor].CGColor;
        }
            break;
        case 114:
        {
            [shijiangBtn   setTitleColor:LSNavColor forState:0];
            shijiangBtn.layer.backgroundColor  =[UIColor whiteColor].CGColor;
            [shuokeBtn     setTitleColor:LSNavColor forState:0];
            shuokeBtn.layer.backgroundColor    =[UIColor whiteColor].CGColor;
            [dabianBtn     setTitleColor:LSNavColor forState:0];
            dabianBtn.layer.backgroundColor    =[UIColor whiteColor].CGColor;
            [jiegouhuaBtn  setTitleColor:[UIColor whiteColor] forState:0];
            jiegouhuaBtn.layer.backgroundColor =LSNavColor.CGColor;
        }
            break;
        case 115:
        {
            if (btn.selected) {
                UIImage  *image                =[UIImage imageNamed:@"xuan"];
                [chooseImageBtn setImage:image forState:0];
                chooseImageBtn.selected=NO;
                
            }else{
                UIImage  *image                =[UIImage imageNamed:@"xuanz"];
                [chooseImageBtn setImage:image forState:0];
                chooseImageBtn.selected=YES;
            }
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
