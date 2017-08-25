//
//  LsEvaluateViewController.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsEvaluateViewController.h"
#import "XHStarRateView.h"
#import "LsShareEvaluateViewController.h"

@interface LsEvaluateViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    UITextView           *textView_;
    UITextField          *textField_;
    UIView               *backView;
}

@property (nonatomic,strong)    NSString             *starNum;
@property (nonatomic,strong)    NSMutableDictionary  *dataDict;

@end

@implementation LsEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle     =@"评价页面";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    _dataDict                 =[NSMutableDictionary dictionary];
    [self loadBaseUI];
}

-(void)loadBaseUI{
    backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, LSMainScreenH)];
    [superView addSubview:backView];
    [superView bringSubviewToFront:self.navView];
    UIView *backgroundView         =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 90*LSScale)];
    backgroundView.backgroundColor =LSNavColor;
    [backView addSubview:backgroundView];
    
    UIView  *headerView            =[[UIView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMidY(backgroundView.frame), LSMainScreenW-20*LSScale, 140*LSScale)];
    headerView.backgroundColor     =[UIColor whiteColor];
    headerView.layer.cornerRadius  =6;
    [backView addSubview:headerView];
    
    UIImageView  *iconView         =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 60*LSScale, 60*LSScale)];
    iconView.center                =CGPointMake(CGRectGetMidX(superView.frame)-5*LSScale, 0);
    iconView.backgroundColor       =[UIColor cyanColor];
    iconView.layer.cornerRadius    =30*LSScale;
    iconView.layer.masksToBounds   =YES;
    [headerView addSubview:iconView];
    
    UILabel  *titleL               =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame)+5*LSScale, headerView.frame.size.width, 25*LSScale)];
    titleL.text                    =_title_;
    titleL.textAlignment           =NSTextAlignmentCenter;
    titleL.font                    =[UIFont boldSystemFontOfSize:20*LSScale];
    [headerView addSubview:titleL];
    
    textField_       =[[UITextField alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-45*LSScale, CGRectGetMaxY(titleL.frame)+5*LSScale, 90*LSScale, 25*LSScale)];
    textField_.keyboardType         = UIKeyboardTypeNumberPad;
    textField_.textAlignment        =NSTextAlignmentCenter;
    textField_.textColor            =LSColor(255, 90, 122, 1);
    textField_.delegate             =self;
    textField_.font                 =[UIFont systemFontOfSize:17*LSScale];
    [headerView addSubview:textField_];
    
    UIView *line                   =[[UIView alloc] initWithFrame:CGRectMake(textField_.frame.origin.x, CGRectGetMaxY(textField_.frame), textField_.frame.size.width, 1)];
    line.backgroundColor           =LSLineColor;
    [headerView addSubview:line];
    
    UILabel   *textFL              =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textField_.frame), textField_.frame.origin.y, 40*LSScale, 25*LSScale)];
    textFL.text                    =@"元";
    textFL.font                    =[UIFont systemFontOfSize:17*LSScale];
    textFL.textColor               =[UIColor darkTextColor];
    textFL.textAlignment           =NSTextAlignmentLeft;
    [headerView addSubview:textFL];

    UILabel   *promptL             =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+5*LSScale, headerView.frame.size.width, 35*LSScale)];
    promptL.text                   =@"输入打赏金额";
    promptL.font                   =[UIFont systemFontOfSize:17*LSScale];
    promptL.textColor              =[UIColor darkGrayColor];
    promptL.textAlignment          =NSTextAlignmentCenter;
    [headerView addSubview:promptL];
    
    UIView  *midView               =[[UIView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(headerView.frame)+10*LSScale, LSMainScreenW-20*LSScale, 190*LSScale)];
    midView.backgroundColor        =[UIColor whiteColor];
    midView.layer.cornerRadius     =6;
    [backView addSubview:midView];
    
    __weak typeof(self) weakSelf = self;
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10*LSScale, 10*LSScale, 180*LSScale, 30*LSScale) finish:^(CGFloat currentScore) {
        LsLog(@"给了%f颗星星--------",currentScore);
        weakSelf.starNum =[NSString stringWithFormat:@"%d",(int)currentScore];
        [weakSelf.dataDict setObject:[NSString stringWithFormat:@"%f",currentScore] forKey:@"star"];
    }];
    [midView addSubview:starRateView];
    
    UILabel *starL        =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starRateView.frame)+10*LSScale, 10*LSScale,CGRectGetWidth(midView.frame)-20*LSScale-CGRectGetMaxX(starRateView.frame), 30*LSScale)];
    starL.text           =@"评价一下吧";
    starL.textColor      =LSNavColor;
    starL.font           =[UIFont systemFontOfSize:17*LSScale];
    starL.textAlignment  =NSTextAlignmentCenter;
    [midView addSubview:starL];
    
    textView_      =[[UITextView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(starRateView.frame)+10*LSScale, midView.frame.size.width-20*LSScale, midView.frame.size.height-25*LSScale-CGRectGetMaxY(starRateView.frame))];
    textView_.delegate         =self;
    textView_.font             =[UIFont systemFontOfSize:16*LSScale];
    textView_.scrollEnabled    =NO;
    textView_.layer.borderColor=LSLineColor.CGColor;
    textView_.layer.borderWidth=1;
    textView_.textColor        =[UIColor darkGrayColor];
    textView_.text             =@"写下您对这次直播的评价吧~~~";
    [midView addSubview:textView_];

    
    UIButton  *submitBtn           =[[UIButton alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(midView.frame)+20*LSScale, LSMainScreenW-20*LSScale, 36*LSScale)];
    submitBtn.layer.cornerRadius   =18*LSScale;
    submitBtn.layer.backgroundColor=LSNavColor.CGColor;
    [submitBtn setTitle:@"立即提交" forState:0];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:0];
    [submitBtn addTarget:self action:@selector(didcClickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:submitBtn];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_dataDict setObject:textField.text forKey:@"money"];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text      =@"";
    textView.textColor =[UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([LsMethod haveValue:textView_.text]) {
        [_dataDict setObject:textView_.text forKey:@"text"];
    }
}

-(void)didcClickSubmitBtn{
    if (_starNum||(![textView_.text isEqualToString:@"写下您对这次直播的评价吧~~~"]&&[LsMethod haveValue:textView_.text])) {
        [self evaluateSuccess];
    }else{
        [LsMethod alertMessage:@"赏几颗星星吧" WithTime:2];
    }
}

-(void)evaluateSuccess{
    LsShareEvaluateViewController *vc =[[LsShareEvaluateViewController alloc] init];
    vc.title_                         =_title_;
    vc.starNum                        =_starNum;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
