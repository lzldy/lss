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
    UIView       *backgroundView;
    LsShareModel *shareModel;
}
@end

@implementation LsShareEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"评价分享";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"top_background"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW, topImage.size.height)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    [superView bringSubviewToFront:self.navView];
    
    backgroundView =[[UIView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(self.navView.frame), LSMainScreenW-20*LSScale, 235*LSScale)];
    backgroundView.backgroundColor     =[UIColor whiteColor];
    backgroundView.layer.cornerRadius  =5;
    [superView addSubview:backgroundView];
    
    UIImageView *headIcon   =[[UIImageView alloc] initWithFrame:CGRectMake(15*LSScale, 15*LSScale, 40*LSScale, 40*LSScale)];
    headIcon.layer.cornerRadius =20*LSScale;
    headIcon.layer.masksToBounds=YES;
    headIcon.backgroundColor    =[UIColor cyanColor];
    [headIcon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"AppIcon"]];
    [backgroundView addSubview:headIcon];
    
    UILabel *typeL          =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headIcon.frame)+5*LSScale, 3*LSScale+headIcon.frame.origin.y, 150*LSScale, 17*LSScale)];
    typeL.text              =@"吕宁";
    typeL.font              =[UIFont systemFontOfSize:13.5*LSScale];
    typeL.textColor         =[UIColor darkTextColor];
    typeL.textAlignment     =NSTextAlignmentLeft;
    [backgroundView addSubview:typeL];
    
    UILabel *timeL          =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headIcon.frame)+5*LSScale,CGRectGetMaxY(headIcon.frame)-20*LSScale, 150*LSScale, 17*LSScale)];
    timeL.text              =@"8月8 我在良师说";
    timeL.font              =[UIFont systemFontOfSize:13*LSScale];
    timeL.textColor         =[UIColor darkTextColor];
    timeL.textAlignment     =NSTextAlignmentLeft;
    [backgroundView addSubview:timeL];
    
    UIView  *line           =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headIcon.frame)+10*LSScale, backgroundView.frame.size.width, 0.5*LSScale)];
    line.backgroundColor    =LSLineColor;
    [backgroundView addSubview:line];
    
    UILabel *titleL          =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(line.frame)+15*LSScale, backgroundView.frame.size.width, 30*LSScale)];
    titleL.text              =[NSString stringWithFormat:@"送给“%@”",_title_];
    titleL.font              =[UIFont systemFontOfSize:19*LSScale];
    titleL.textColor         =[UIColor darkTextColor];
    titleL.textAlignment     =NSTextAlignmentCenter;
    [backgroundView addSubview:titleL];
    
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width/2-115*LSScale, CGRectGetMaxY(titleL.frame)+8*LSScale, 230*LSScale, 30*LSScale) numberOfStars:[_starNum floatValue]];
    [backgroundView addSubview:starRateView];
    
    UILabel *starL          =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(starRateView.frame)+10*LSScale, backgroundView.frame.size.width, 25*LSScale)];
    if ([LsMethod haveValue:_money]) {
        starL.text          =[NSString stringWithFormat:@"%ld星好评并打赏了%@元",(long)[_starNum integerValue],_money];
    }else{
        starL.text          =[NSString stringWithFormat:@"%@星好评",_starNum];
    }
    starL.font              =[UIFont systemFontOfSize:17*LSScale];
    starL.textColor         =LSNavColor;
    starL.textAlignment     =NSTextAlignmentCenter;
    [backgroundView addSubview:starL];
    
    UILabel *desL          =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(starL.frame)+8*LSScale, backgroundView.frame.size.width, 20*LSScale)];
    desL.text              =@"你也快来吧!所有直播都能回放哦!";
    desL.font              =[UIFont systemFontOfSize:14*LSScale];
    desL.textColor         =[UIColor darkGrayColor];
    desL.textAlignment     =NSTextAlignmentCenter;
    [backgroundView addSubview:desL];
    
    UIButton  *shareBtn            =[[UIButton alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(backgroundView.frame)+35*LSScale, LSMainScreenW-20*LSScale, 42*LSScale)];
    shareBtn.layer.cornerRadius   =5*LSScale;
    shareBtn.layer.backgroundColor=LSNavColor.CGColor;
    [shareBtn setTitle:@"立即分享页面" forState:0];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:0];
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
    CGRect rect = CGRectMake(backgroundView.frame.origin.x*lsScale+5*lsScale,backgroundView.frame.origin.y*lsScale+5*lsScale, backgroundView.frame.size.width*lsScale-10*lsScale, backgroundView.frame.size.height*lsScale-10*lsScale);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage * Image =[[UIImage alloc] initWithCGImage:imageRefRect];
    shareImage =Image;
    CGImageRelease(imageRefRect);
    
    [shareModel shareActionWithImage:shareImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
