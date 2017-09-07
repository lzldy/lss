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

@interface LsPumpingTestViewController ()<rightChooseViewDelegate>
{
    LsButton     *rightBtn;
    UIButton     *startBtn;
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
    
    startBtn         =[[UIButton alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(midView.frame)+30*LSScale, LSMainScreenW-30*LSScale, 38*LSScale)];
    startBtn.layer.backgroundColor =LSColor(153, 153, 153, 1).CGColor;
    startBtn.layer.cornerRadius    =6*LSScale;
    [startBtn setTitle:@"开始抽题" forState:0];
    [startBtn setTitleColor:[UIColor whiteColor] forState:0];
    startBtn.titleLabel.font       =[UIFont systemFontOfSize:15*LSScale];
    [startBtn addTarget:self action:@selector(didClickStartBnt:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)didClickStartBnt:(UIButton*)btn{
    LsProFormaViewController *vc =[[LsProFormaViewController alloc] init];
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
    [LsMethod alertMessage:[NSString stringWithFormat:@"%ld",(long)button.tag] WithTime:1.5];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hiddenTestChooseView];
}

-(LsTestChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView            =[[LsTestChooseView alloc] init];
        _chooseView.dataArray  =@[@{@"title":@"录制视频",@"image":@"luzhi"},
                                  @{@"title":@"上传视频",@"image":@"luzhi"},
                                  @{@"title":@"上传视频",@"image":@"luzhi"},
                                  @{@"title":@"上传视频",@"image":@"luzhi"},
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
