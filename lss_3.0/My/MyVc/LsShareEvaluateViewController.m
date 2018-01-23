//
//  LsShareEvaluateViewController.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsShareEvaluateViewController.h"
#import "XHStarRateView.h"
#import "LsShareModel.h"


@interface LsShareEvaluateViewController ()
{
    UIImage      *shareImage;
    UIImageView  *imageview;
}

@property (nonatomic,strong)     LsShareModel *shareModel;

@end

@implementation LsShareEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"评价分享";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    
    UIImage      *image     =LOADIMAGE(@"pj_bj");
    imageview =[[UIImageView alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(self.navView.frame)+20*LSScale, LSMainScreenW-60*LSScale, image.size.height/image.size.width*(LSMainScreenW-60*LSScale))];
    imageview.image         =image;
    [superView addSubview:imageview];
    
    UIImageView  *iconView         =[[UIImageView alloc] initWithFrame:CGRectMake(12*LSScale,12*LSScale, 50*LSScale, 50*LSScale)];
    [iconView sd_setImageWithURL:[LsSingleton sharedInstance].user.face placeholderImage:LOADIMAGE(@"touxiang_icon")];
    iconView.layer.cornerRadius    =25*LSScale;
    iconView.layer.masksToBounds   =YES;
    [imageview addSubview:iconView];
    
    UILabel     *nameL             =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+12*LSScale,CGRectGetMidY(iconView.frame)-20*LSScale, 100*LSScale, 20*LSScale)];
    if ([LsMethod haveValue:[LsSingleton sharedInstance].user.nickName]) {
        nameL.text          =[LsSingleton sharedInstance].user.nickName;
    }else{
        nameL.text          =@"良师老友";
    }
    nameL.font              =[UIFont systemFontOfSize:13.5*LSScale];
    nameL.textColor         =[UIColor whiteColor];
    nameL.textAlignment     =NSTextAlignmentLeft;
    [imageview addSubview:nameL];
    
    UILabel *timeL          =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+12*LSScale,CGRectGetMidY(iconView.frame), 150*LSScale, 20*LSScale)];
    NSDate   *senddate      = [NSDate date];
    NSString *date2         = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    NSString *time          = [LsMethod toDateWithTimeStamp:date2 DateFormat:@"MM月dd"];
    timeL.text              =[NSString stringWithFormat:@"%@  我在良师说",time];
    timeL.font              =[UIFont systemFontOfSize:13*LSScale];
    timeL.textColor         =[UIColor whiteColor];
    timeL.textAlignment     =NSTextAlignmentLeft;
    [imageview addSubview:timeL];
    
    UIImage      *lineImage =LOADIMAGE(@"fgx");
    UIImageView  *line      =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame)+10*LSScale, imageview.frame.size.width,lineImage.size.height)];
    line.image              =lineImage;
    [imageview addSubview:line];
    
    UILabel *titleL          =[[UILabel alloc] init];
    titleL.text              =[NSString stringWithFormat:@"送给\n“%@”直播课",_title_];
    titleL.font              =[UIFont systemFontOfSize:16*LSScale];
    titleL.textColor         =[UIColor whiteColor];
    titleL.numberOfLines     =0;
    titleL.textAlignment     =NSTextAlignmentLeft;
    CGSize  size             =[LsMethod sizeWithSize:imageview.frame.size String:titleL.text font:titleL.font];
    titleL.frame             =CGRectMake(8*LSScale,CGRectGetMaxY(line.frame)+15*LSScale, imageview.frame.size.width-16*LSScale, size.height);
    [imageview addSubview:titleL];
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(imageview.frame.size.width/2-115*LSScale, CGRectGetMaxY(titleL.frame)+8*LSScale, 230*LSScale, 30*LSScale) numberOfStars:[_starNum floatValue]];
    [imageview addSubview:starRateView];
    
    UILabel *starL          =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(starRateView.frame)+12*LSScale, imageview.frame.size.width, 25*LSScale)];
    if ([LsMethod haveValue:_money]) {
        starL.text          =[NSString stringWithFormat:@"%ld星好评并打赏了%@元",(long)[_starNum integerValue],_money];
    }else{
        starL.text          =[NSString stringWithFormat:@"%@星好评",_starNum];
    }
    starL.font              =[UIFont systemFontOfSize:20*LSScale];
    starL.textColor         =LSColor(248, 255, 0, 1);
    starL.textAlignment     =NSTextAlignmentCenter;
    [imageview addSubview:starL];
    
    UIImage      *image2    =LOADIMAGE(@"ewm");
    UIImageView  *imageV2   =[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageview.frame)/2-image2.size.width/2,13*LSScale+CGRectGetMaxY(starL.frame),image2.size.width,image2.size.height)];
    imageV2.image           =image2;
    [imageview addSubview:imageV2];
    
    UILabel *desL          =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageV2.frame)+8*LSScale, imageview.frame.size.width, 20*LSScale)];
    desL.text              =@"所有直播无限回放 等你来听";
    desL.font              =[UIFont systemFontOfSize:13.5*LSScale];
    desL.textColor         =[UIColor whiteColor];
    desL.textAlignment     =NSTextAlignmentCenter;
    [imageview addSubview:desL];
    
    UIImage   *btnImage       =LOADIMAGE(@"yq_an");
    UIButton  *shareBtn       =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/2-btnImage.size.width/2, LSMainScreenH-80*LSScale,btnImage.size.width,btnImage.size.height)];
    [shareBtn setImage:btnImage forState:0];
    [shareBtn addTarget:self action:@selector(didcClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:shareBtn];
}

- (void)didcClickShareBtn{
    [self ScreenShot];
}

-(void)ScreenShot{
    CGFloat lsScale =[UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(superView.bounds.size, YES,0);//设置截屏大小
    [superView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef =viewImage.CGImage;
    CGRect rect = CGRectMake(imageview.frame.origin.x*lsScale+3*lsScale,imageview.frame.origin.y*lsScale+3*lsScale, imageview.frame.size.width*lsScale-8*lsScale, imageview.frame.size.height*lsScale-8*lsScale);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage * Image =[[UIImage alloc] initWithCGImage:imageRefRect];
    shareImage =Image;
    CGImageRelease(imageRefRect);
    
    [self.shareModel shareActionWithImage:shareImage OnVc:self];
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
