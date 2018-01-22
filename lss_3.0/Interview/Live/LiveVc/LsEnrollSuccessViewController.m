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
#import "LsLiveDetailViewController.h"
#import "CCSDK/CCLiveUtil.h"
#import "CCSDK/RequestData.h"
#import "PlayForPCVC.h"
#import "PlayBackVC.h"
#import "CCSDK/RequestDataPlayBack.h"
#import "LsPlayBackViewController.h"
@interface LsEnrollSuccessViewController ()<RequestDataDelegate,RequestDataPlayBackDelegate>
{
    UIImageView  *imageview;
}
@property (nonatomic,strong)      LsShareModel       *shareModel;
@property (nonatomic,strong)      MBProgressHUD      *hud;

@end

@implementation LsEnrollSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"报名成功";
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage      *image     =LOADIMAGE(@"bm_bj");
    imageview =[[UIImageView alloc] initWithFrame:CGRectMake(35*LSScale, CGRectGetMaxY(self.navView.frame)+30*LSScale, LSMainScreenW-70*LSScale, image.size.height/image.size.width*(LSMainScreenW-70*LSScale))];
    imageview.image         =image;
    [superView addSubview:imageview];
    
    UIImage      *image1    =LOADIMAGE(@"cg_tb");
    UIImageView  *imageV1   =[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageview.frame)/2-image1.size.width/2+10*LSScale+5,12*LSScale,image1.size.width-20*LSScale,image1.size.height-18*LSScale)];
    imageV1.image           =image1;
    [imageview addSubview:imageV1];
    
    UILabel      *label     =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV1.frame)+5*LSScale, CGRectGetWidth(imageview.frame), 25*LSScale)];
    label.text              =@"报名成功";
    label.textColor         =LSColor(0, 146, 193, 1);
    label.textAlignment     =NSTextAlignmentCenter;
    label.font              =[UIFont boldSystemFontOfSize:18*LSScale];
    [imageview  addSubview:label];
    
    UILabel    *titleL      =[[UILabel alloc] initWithFrame:CGRectMake(0, 5*LSScale+CGRectGetMaxY(label.frame),CGRectGetWidth(imageview.frame), 50*LSScale)];
    titleL.text             =_model.title;
    titleL.textColor        =LSColor(0, 146, 193, 1);
    titleL.textAlignment    =NSTextAlignmentCenter;
    titleL.numberOfLines    =0;
    titleL.font             =[UIFont boldSystemFontOfSize:18*LSScale];
    [imageview addSubview:titleL];
    
    
    UILabel      *label1     =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+5*LSScale, CGRectGetWidth(imageview.frame), 20*LSScale)];
    label1.text              =@"良师邀你一起听直播";
    label1.textColor         =LSColor(0, 146, 193, 1);
    label1.textAlignment     =NSTextAlignmentCenter;
    label1.font              =[UIFont systemFontOfSize:13*LSScale];
    [imageview  addSubview:label1];
    
    UIImage      *image2    =LOADIMAGE(@"ewm");
    UIImageView  *imageV2   =[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageview.frame)/2-image2.size.width/2,25*LSScale+CGRectGetMaxY(label1.frame),image2.size.width,image2.size.height)];
    imageV2.image           =image2;
    [imageview addSubview:imageV2];
    
    UILabel      *label2     =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV2.frame)+5*LSScale, CGRectGetWidth(imageview.frame), 18*LSScale)];
    label2.text              =@"安装良师说APP一起听直播";
    label2.textColor         =LSColor(255, 158, 0, 1);
    label2.textAlignment     =NSTextAlignmentCenter;
    label2.font              =[UIFont systemFontOfSize:12*LSScale];
    [imageview  addSubview:label2];
    
    
    UIImage   *btnImage       =LOADIMAGE(@"fx_an");
    UIButton  *shareBtn       =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/2-btnImage.size.width/2, LSMainScreenH-60*LSScale,btnImage.size.width,btnImage.size.height)];
//    shareBtn.backgroundColor  =LSColor(252, 48, 14, 1);
//    [shareBtn setTitle:@"邀请闺蜜共同学习" forState:0];
//    [shareBtn setTitleColor:[UIColor whiteColor] forState:0];
    [shareBtn setImage:btnImage forState:0];
    [shareBtn addTarget:self action:@selector(didClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:shareBtn];
   
//    _model.isPackage =NO;
//    if (!_model.isPackage) {
//        UIButton * intoBtn=[[UIButton alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(imageview.frame)+35*LSScale, LSMainScreenW-60*LSScale, 40*LSScale)];
//        intoBtn.backgroundColor  =LSNavColor;
//        [intoBtn setTitle:@"进入直播间" forState:0];
//        [intoBtn setTitleColor:[UIColor whiteColor] forState:0];
//        [intoBtn addTarget:self action:@selector(didClickIntoBtn) forControlEvents:UIControlEventTouchUpInside];
//        [superView addSubview:intoBtn];
//
//
//        UILabel  *bottomL  =[[UILabel alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(intoBtn.frame)+10*LSScale, LSMainScreenW-60*LSScale, 20*LSScale)];
//        bottomL.textColor  =LSNavColor;
//        bottomL.text       =@"注:您可以在“我报名的直播课”中进行查看";
//        bottomL.textAlignment =NSTextAlignmentCenter;
//        bottomL.font       =[UIFont systemFontOfSize:13*LSScale];
//        [superView addSubview:bottomL];
//        shareBtn.frame =CGRectMake(30*LSScale, CGRectGetMaxY(intoBtn.frame)+12*LSScale, LSMainScreenW-60*LSScale, 40*LSScale);
//    }
    
//    UILabel  *bottomL  =[[UILabel alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(shareBtn.frame)+10*LSScale, LSMainScreenW-60*LSScale, 20*LSScale)];
//    bottomL.textColor  =LSNavColor;
//    bottomL.text       =@"注:您可以在“我报名的直播课”中进行查看";
//    bottomL.textAlignment =NSTextAlignmentCenter;
//    bottomL.font       =[UIFont systemFontOfSize:13*LSScale];
//    [superView addSubview:bottomL];
    
}

-(void)didClickShareBtn{
//    [LsMethod alertMessage:@"分享" WithTime:2];
//    [self.shareModel shareActionWithUrl:@"www.baidu.com" OnVc:self];
    [self ScreenShot];
}

-(void)ScreenShot{
    CGFloat lsScale =[UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(superView.bounds.size, YES,0);//设置截屏大小
    [superView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef =viewImage.CGImage;
    CGRect rect = CGRectMake(imageview.frame.origin.x*lsScale+3*lsScale,imageview.frame.origin.y*lsScale+3*lsScale, imageview.frame.size.width*lsScale-6*lsScale, imageview.frame.size.height*lsScale-6*lsScale);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage * Image =[[UIImage alloc] initWithCGImage:imageRefRect];
//    shareImage =Image;
    CGImageRelease(imageRefRect);
    
    [self.shareModel shareActionWithImage:Image OnVc:self];
}


-(void)didClickIntoBtn{
    LsCourseArrangementModel *modelll = self.model.courseArrangement[0];
    if ([modelll.livestatus isEqualToString:@"0"]) {
        //直播
        PlayParameter *parameter = [[PlayParameter alloc] init];
        parameter.userId = CCLIVE_USERID;
        parameter.roomId = modelll.videoId;
        parameter.viewerName = [LsSingleton sharedInstance].user.nickName;
        parameter.token  =@"shishuo";
        parameter.security = NO;
        parameter.viewercustomua = @"viewercustomua";
        if (![LsMethod haveValue:parameter.viewerName]) {
            parameter.viewerName =@"ios";
        }
        SaveToUserDefaults(WATCH_USERID,CCLIVE_USERID);
        SaveToUserDefaults(WATCH_ROOMID,modelll.videoId);
        SaveToUserDefaults(WATCH_USERNAME,parameter.viewerName);
        SaveToUserDefaults(WATCH_PASSWORD,@"shishuo");
        
        RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
        requestData.delegate = self;
    }else{
        [LsMethod alertMessage:@"暂未开始" WithTime:1.5];
    }
}

#pragma mark - CCPushDelegate
-(void)loginSucceedPlay {
    [_hud hide:YES];
    LSApplication.idleTimerDisabled=YES;//不锁屏
    PlayForPCVC *playForPCVC = [[PlayForPCVC alloc] initWithLeftLabelText:@"直播"];
    [self presentViewController:playForPCVC animated:YES completion:nil];
}

-(void)loginFailed:(NSError *)error reason:(NSString *)reason {
    [_hud hide:YES];
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    [LsMethod alertMessage:message WithTime:2];
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
