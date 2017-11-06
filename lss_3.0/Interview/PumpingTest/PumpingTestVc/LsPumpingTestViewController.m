//
//  LsPumpingTestViewController.m
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPumpingTestViewController.h"
#import "LsButton.h"
#import "LsTestChooseView.h"
#import "LsProFormaViewController.h"
#import "LsVideotapeViewController.h"

@interface LsPumpingTestViewController ()<rightChooseViewDelegate>
{
    LsButton     *rightBtn;
    UIButton     *startBtn;
    LsButton     *shijiangBtn;
    LsButton     *shuokeBtn;
    LsButton     *jigouhuaBtn;
    LsButton     *dabianBtn;
    NSString     *ctag1;

}
@property (nonatomic,strong)  LsTestChooseView *chooseView;

@end

@implementation LsPumpingTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle      =@"抽题考试";
    superView.backgroundColor  =LSColor(251, 243, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    
    rightBtn         =[[LsButton alloc] initWithFrame:CGRectMake(LSMainScreenW-15*LSScale-70*LSScale, 20, 60*LSScale, 44)];
    UIImage  *xlImage          =[UIImage imageNamed:@"xl"];
    rightBtn.lsImageView.frame =CGRectMake(rightBtn.frame.size.width-xlImage.size.width, 22-xlImage.size.height/2, xlImage.size.width, xlImage.size.height);
    rightBtn.lsImageView.image =xlImage;
    rightBtn.lsLabel.frame     =CGRectMake(0, 0, rightBtn.frame.size.width-xlImage.size.width-5, 44);
    rightBtn.lsLabel.text      =@"视频";
    rightBtn.lsLabel.textColor =[UIColor whiteColor];
    rightBtn.lsLabel.textAlignment =NSTextAlignmentRight;
    rightBtn.lsLabel.font      =[UIFont systemFontOfSize:17];
    [rightBtn addTarget:self action:@selector(videoRecordingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBtn];
    
    UIImage     *image      =[UIImage imageNamed:@"test_back"];
    UIImageView *backImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW,LSMainScreenW/image.size.width*image.size.height)];
    backImageV.image        =image;
    [superView addSubview:backImageV];
    
    UIImage       *midImage =[UIImage imageNamed:@"ms_bj"];
    UIImageView   *midView  =[[UIImageView alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(self.navView.frame), LSMainScreenW-30*LSScale,(LSMainScreenW-30*LSScale)/midImage.size.width*midImage.size.height)];
    midView.image           =midImage;
    [superView addSubview:midView];
    
    shijiangBtn                    =[[LsButton alloc] initWithFrame:CGRectMake(60*LSScale, CGRectGetMinY(midView.frame)+80*LSScale, 70*LSScale, 60*LSScale)];
    UIImage   *shijiangImage       =[UIImage imageNamed:@"sj"];
    shijiangBtn.lsImageView.frame  =CGRectMake(CGRectGetWidth(shijiangBtn.frame)/2-shijiangImage.size.width/2, 0, shijiangImage.size.width, shijiangImage.size.height);
    shijiangBtn.lsImageView.image  =shijiangImage;
    shijiangBtn.lsLabel.frame      =CGRectMake(0,CGRectGetHeight(shijiangBtn.frame)-25*LSScale, CGRectGetWidth(shijiangBtn.frame), 25*LSScale);
    shijiangBtn.lsLabel.text       =@"试课/试讲";
    shijiangBtn.lsLabel.font       =[UIFont systemFontOfSize:12*LSScale];
    shijiangBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    shijiangBtn.lsLabel.textColor  =[UIColor grayColor];
    shijiangBtn.tag                =0;
    [shijiangBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:shijiangBtn];
    
    shuokeBtn                    =[[LsButton alloc] initWithFrame:CGRectMake(LSMainScreenW-60*LSScale-70*LSScale, CGRectGetMinY(midView.frame)+80*LSScale, 70*LSScale, 60*LSScale)];
    UIImage   *shuokeimage       =[UIImage imageNamed:@"sk"];
    shuokeBtn.lsImageView.frame  =CGRectMake(CGRectGetWidth(shuokeBtn.frame)/2-shuokeimage.size.width/2, 0, shuokeimage.size.width, shuokeimage.size.height);
    shuokeBtn.lsImageView.image  =shuokeimage;
    shuokeBtn.lsLabel.frame      =CGRectMake(0,CGRectGetHeight(shuokeBtn.frame)-25*LSScale, CGRectGetWidth(shuokeBtn.frame), 25*LSScale);
    shuokeBtn.lsLabel.text       =@"说课";
    shuokeBtn.lsLabel.font       =[UIFont systemFontOfSize:12*LSScale];
    shuokeBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    shuokeBtn.lsLabel.textColor  =[UIColor grayColor];
    shuokeBtn.tag                =1;
    [shuokeBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:shuokeBtn];

    jigouhuaBtn                    =[[LsButton alloc] initWithFrame:CGRectMake(60*LSScale, CGRectGetMaxY(shijiangBtn.frame)+60*LSScale, 70*LSScale, 60*LSScale)];
    UIImage   *jigouhuaImage       =[UIImage imageNamed:@"jgh"];
    jigouhuaBtn.lsImageView.frame  =CGRectMake(CGRectGetWidth(jigouhuaBtn.frame)/2-jigouhuaImage.size.width/2, 0, jigouhuaImage.size.width, jigouhuaImage.size.height);
    jigouhuaBtn.lsImageView.image  =jigouhuaImage;
    jigouhuaBtn.lsLabel.frame      =CGRectMake(0, CGRectGetHeight(jigouhuaBtn.frame)-25*LSScale, CGRectGetWidth(jigouhuaBtn.frame),25*LSScale);
    jigouhuaBtn.lsLabel.text       =@"结构化面试";
    jigouhuaBtn.lsLabel.font       =[UIFont systemFontOfSize:12*LSScale];
    jigouhuaBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    jigouhuaBtn.tag                =2;
    jigouhuaBtn.lsLabel.textColor  =[UIColor grayColor];
    [jigouhuaBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:jigouhuaBtn];

    dabianBtn                    =[[LsButton alloc] initWithFrame:CGRectMake(LSMainScreenW-60*LSScale-70*LSScale, CGRectGetMaxY(shijiangBtn.frame)+60*LSScale, 70*LSScale, 60*LSScale)];
    UIImage   *dabianImage       =[UIImage imageNamed:@"db"];
    dabianBtn.lsImageView.frame  =CGRectMake(CGRectGetWidth(dabianBtn.frame)/2-dabianImage.size.width/2, 0, dabianImage.size.width, dabianImage.size.height);
    dabianBtn.lsImageView.image  =dabianImage;
    dabianBtn.lsLabel.frame      =CGRectMake(0, CGRectGetHeight(dabianBtn.frame)-25*LSScale, CGRectGetWidth(dabianBtn.frame), 25*LSScale);
    dabianBtn.lsLabel.text       =@"试课/试讲";
    dabianBtn.lsLabel.font       =[UIFont systemFontOfSize:12*LSScale];
    dabianBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    dabianBtn.tag                =3;
    dabianBtn.lsLabel.textColor  =[UIColor grayColor];
    [dabianBtn addTarget:self action:@selector(didClickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:dabianBtn];

    
    startBtn                       =[[UIButton alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(midView.frame)+30*LSScale, LSMainScreenW-30*LSScale, 38*LSScale)];
    startBtn.layer.backgroundColor =LSColor(153, 153, 153, 1).CGColor;
    startBtn.layer.cornerRadius    =6*LSScale;
    [startBtn setTitle:@"开始抽题" forState:0];
    [startBtn setTitleColor:[UIColor whiteColor] forState:0];
    startBtn.titleLabel.font       =[UIFont systemFontOfSize:15*LSScale];
    [startBtn addTarget:self action:@selector(didClickStartBnt:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.userInteractionEnabled =NO;
    [superView addSubview:startBtn];
    
    UILabel  *bottomL     =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startBtn.frame)+20*LSScale, LSMainScreenW, 60*LSScale)];
    bottomL.numberOfLines =0;
    bottomL.textColor     =LSColor(114, 114, 114, 1);
    bottomL.font          =[UIFont systemFontOfSize:12*LSScale];
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:10*LSScale];
    NSString  *testString = @"抽题将根据你选择的考试类型和科目进行设定\n若不符合,您可进入个人中心修改";
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    [bottomL  setAttributedText:setString];
    bottomL.textAlignment =NSTextAlignmentCenter;
    [superView addSubview:bottomL];
    
    [superView addSubview:self.chooseView];
}

-(void)didClickTypeBtn:(LsButton*)btn{
    startBtn.userInteractionEnabled =YES;
    startBtn.layer.backgroundColor  =LSNavColor.CGColor;
    [self reSetImageAndTextColor];
    if (btn.tag==0) {
        ctag1         =@"SJ";
        shijiangBtn.lsImageView.image =[UIImage imageNamed:@"sj_s"];
        shijiangBtn.lsLabel.textColor =LSNavColor;
    }else if (btn.tag==1){
        ctag1         =@"SK";
        shuokeBtn.lsImageView.image =[UIImage imageNamed:@"sk_s"];
        shuokeBtn.lsLabel.textColor =LSNavColor;
    }else if (btn.tag==2){
        ctag1         =@"JGH";
        jigouhuaBtn.lsImageView.image =[UIImage imageNamed:@"jgh_s"];
        jigouhuaBtn.lsLabel.textColor =LSNavColor;
    }else if (btn.tag==3){
        ctag1         =@"DB";
        dabianBtn.lsImageView.image =[UIImage imageNamed:@"db_s"];
        dabianBtn.lsLabel.textColor =LSNavColor;
    }
}

-(void)reSetImageAndTextColor{
    shijiangBtn.lsImageView.image =[UIImage imageNamed:@"sj"];
    shijiangBtn.lsLabel.textColor =[UIColor grayColor];
    
    shuokeBtn.lsImageView.image   =[UIImage imageNamed:@"sk"];
    shuokeBtn.lsLabel.textColor   =[UIColor grayColor];
    
    jigouhuaBtn.lsImageView.image =[UIImage imageNamed:@"jgh"];
    jigouhuaBtn.lsLabel.textColor =[UIColor grayColor];
    
    dabianBtn.lsImageView.image   =[UIImage imageNamed:@"db"];
    dabianBtn.lsLabel.textColor   =[UIColor grayColor];
}

-(void)didClickStartBnt:(UIButton*)btn{
    LsProFormaViewController *vc =[[LsProFormaViewController alloc] init];
    vc.ctag1                     =ctag1;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)videoRecordingBtn:(LsButton*)button{
    if (button.selected) {
        button.selected            =NO;
        [self hiddenTestChooseView];
    }else{
        button.selected            =YES;
        UIImage  *slImage          =[UIImage imageNamed:@"sl"];
        button.lsImageView.image   =slImage;
        self.chooseView.hidden     =NO;
    }
}

-(void)hiddenTestChooseView{
    rightBtn.selected            =NO;
    self.chooseView.hidden       =YES;
    UIImage  *xlImage            =[UIImage imageNamed:@"xl"];
    rightBtn.lsImageView.image   =xlImage;
}

- (void)rightChooseBtn:(LsButton*)button{
    [self hiddenTestChooseView];
    if (button.tag ==0) {
        LsVideotapeViewController *vc =[[LsVideotapeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [LsMethod alertMessage:@"暂未开放,敬请期待" WithTime:1.5];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hiddenTestChooseView];
}

-(LsTestChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView            =[[LsTestChooseView alloc] init];
        _chooseView.dataArray  =@[@{@"title":@"录制视频",@"image":@"luzhi"},
                                  @{@"title":@"上传视频",@"image":@"luzhi"}];
        _chooseView.hidden     =YES;
        _chooseView.delegate   =self;
    }
    return _chooseView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
