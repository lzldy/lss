//
//  LsLoginViewController.m
//  lss
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLoginViewController.h"
#import "LsTabBarViewController.h"
#import "LsNavView.h"
#import "LsConfigureViewController.h"
#import "LsWebViewController.h"

@interface LsLoginViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    int           countTimer ;
    NSTimer       *timer;
}
@property (nonatomic,strong) UIButton    *nextBtn;
@property (nonatomic,strong) UIView      *phoneView;
@property (nonatomic,strong) UILabel     *label;
@property (nonatomic,strong) UIButton    *codeBtn;

@end

@implementation LsLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor =LSColor(229, 230, 231, 1);
    [superView addSubview:self.navView];
    self.navView.navTitle =@"登录";
    if (_isGetCodeVc) {
        [self initBaseUIOfGetCode];
    }else{
        [self initBaseUI];
    }
}

-(void)initBaseUIOfGetCode{
    UILabel *phoneLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.navView.frame), 200, 45*LSScale)];
    phoneLabel.text     =[NSString stringWithFormat:@"您的手机号:%@",_phoneNumber];
    phoneLabel.font     =[UIFont systemFontOfSize:13];
    phoneLabel.textColor=[UIColor darkTextColor];
    [superView addSubview:phoneLabel];
    
    _phoneView =[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(phoneLabel.frame), LSMainScreenW, 45*LSScale)];
    _phoneView.backgroundColor =[UIColor whiteColor];
    [superView addSubview:_phoneView];

    UILabel  *codeL =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 45*LSScale)];
    codeL.text      =@"验证码:";
    codeL.textColor =[UIColor darkTextColor];
    codeL.font      =[UIFont systemFontOfSize:17.5];
    codeL.textAlignment =NSTextAlignmentRight;
    [_phoneView addSubview:codeL];
    
    UITextField *codeF=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(codeL.frame), 0, LSMainScreenW-110*LSScale-CGRectGetMaxX(codeL.frame), 45*LSScale)];
    codeF.placeholder   =@"请输入验证码";
    codeF.text          =@"1111";
    codeF.delegate      =self;
    codeF.returnKeyType =UIReturnKeyDone;
    codeF.keyboardType  =UIKeyboardTypeNumberPad;
    [_phoneView addSubview:codeF];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:codeF];
    
    _codeBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-88-15, 5, 88, 45*LSScale-10)];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.font  =[UIFont systemFontOfSize:15];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    _codeBtn.layer.cornerRadius=5;
    _codeBtn.layer.backgroundColor =LSNavColor.CGColor;
    [_phoneView addSubview:_codeBtn];
    
    [self loadBottomView];
}

-(void)getCodeBtn:(UIButton*)button{
    LsLog(@"------获取验证码成功----");
    countTimer = 60;
    _codeBtn.userInteractionEnabled=NO;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%d秒",countTimer] forState:UIControlStateNormal];
    timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
}

-(void)daojishi{
    countTimer--;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%d秒",countTimer] forState:UIControlStateNormal];
    if (countTimer == 0) {
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        _codeBtn.userInteractionEnabled=YES;
    }
}


-(void)initBaseUI{
    _phoneView =[[UIView alloc] initWithFrame:CGRectMake(0, 20+CGRectGetMaxY(self.navView.frame), LSMainScreenW, 45*LSScale)];
    _phoneView.backgroundColor =[UIColor whiteColor];
    [superView addSubview:_phoneView];
    
    UILabel  *phoneNum =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 45*LSScale)];
    phoneNum.text      =@"手机号:";
    phoneNum.textColor =[UIColor darkTextColor];
    phoneNum.font      =[UIFont systemFontOfSize:17.5];
    phoneNum.textAlignment =NSTextAlignmentRight;
    [_phoneView addSubview:phoneNum];
    
    UITextField *phoneTf=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phoneNum.frame), 0, LSMainScreenW-80, 45*LSScale)];
    phoneTf.placeholder   =@"请输入手机号";
    phoneTf.text          =@"18888888888";
    phoneTf.delegate      =self;
    phoneTf.returnKeyType =UIReturnKeyDone;
    phoneTf.keyboardType  =UIKeyboardTypeNumberPad;
    [_phoneView addSubview:phoneTf];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:phoneTf];
   
    [self loadBottomView];
}

-(void)loadBottomView{
    _nextBtn    =[[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_phoneView.frame)+30, LSMainScreenW-30, 42*LSScale)];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font  =[UIFont systemFontOfSize:17.5];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
    _nextBtn.layer.cornerRadius =5;
    [_nextBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.userInteractionEnabled =NO;
    [superView addSubview:_nextBtn];
    
    if (!_isGetCodeVc) {
        UILabel *otherL =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW/2-40, LSMainScreenH-170, 80, 25)];
        otherL.text      =@"其他方式登录";
        otherL.textColor =[UIColor darkTextColor];
        otherL.font      =[UIFont systemFontOfSize:12];
        otherL.textAlignment =NSTextAlignmentCenter;
        [superView addSubview:otherL];
        
        UIView *leftLine          =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMidY(otherL.frame), CGRectGetMinX(otherL.frame)-15, 1)];
        leftLine.backgroundColor  =[UIColor darkTextColor];
        [superView addSubview:leftLine];
        
        UIView *rightLine         =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(otherL.frame), CGRectGetMidY(otherL.frame), LSMainScreenW-CGRectGetMaxX(otherL.frame)-15, 1)];
        rightLine.backgroundColor =[UIColor darkTextColor];
        [superView addSubview:rightLine];
        
        UIButton *qqBtn           =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/2-25-60, CGRectGetMaxY(otherL.frame)+10, 60, 60)];
        [qqBtn setImage:[UIImage imageNamed:@"qq_icon"] forState:UIControlStateNormal];
        [qqBtn addTarget:self action:@selector(getAuthWithUserInfoFromQQ) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:qqBtn];
        
        UIButton *wxBtn           =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/2+25, CGRectGetMaxY(otherL.frame)+10, 60, 60)];
        [wxBtn setImage:[UIImage imageNamed:@"wechat_icon"] forState:UIControlStateNormal];
        [wxBtn addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:wxBtn];
        
        NSString *str=@"登录及表示您同意良师说服务和隐私条款";
        NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:str];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:LSNavColor
                                 range:NSMakeRange(str.length-7, 7)];
        _label       =[[UILabel alloc] initWithFrame:CGRectMake(20*LSScale, CGRectGetMaxY(qqBtn.frame)+20, LSMainScreenW-40*LSScale, 25)];
        _label.attributedText =attributedString;
        _label.font           =[UIFont systemFontOfSize:12];
        _label.textAlignment  =NSTextAlignmentCenter;
        [superView addSubview:_label];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigleTappedPickerView:)];
        [singleTap setNumberOfTapsRequired:1];
        [superView addGestureRecognizer:singleTap];
        singleTap.delegate =self;
    }
}

- (void)sigleTappedPickerView:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:superView];
    // 判断该点在不在区域内
    if (CGRectContainsPoint(CGRectMake(CGRectGetMaxX(_label.frame)-115, CGRectGetMinY(_label.frame), 90, 25), point)){
        LsLog(@"-------------点击了隐私条款---------------");
        LsWebViewController *webVc = [[LsWebViewController alloc] init];
        webVc.modalPresentationStyle =UIModalPresentationCustom;
        webVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;
        [self presentViewController:webVc animated:YES completion:nil];
    }
}

-(void)getCode:(UIButton*)button{
    if (_isGetCodeVc) {
        if (![LSUser_Default objectForKey:@"didConfig"]) {
            LsConfigureViewController *conVc = [[LsConfigureViewController alloc] init];
            conVc.modalPresentationStyle =UIModalPresentationCustom;
            conVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;
            [self presentViewController:conVc animated:YES completion:nil];
        }else{
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            LsAppDelegate *appdele=(LsAppDelegate*)[UIApplication sharedApplication].delegate;
            [appdele loadMianTab];
        }
    }else{
        LsLoginViewController *loginVc = [[LsLoginViewController alloc] init];
        loginVc.isGetCodeVc            =YES;
        loginVc.phoneNumber            =[NSString stringWithFormat:@"%ld",(long)button.tag];
        loginVc.modalPresentationStyle =UIModalPresentationCustom;
        loginVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;
        [self presentViewController:loginVc animated:YES completion:nil];
    }
}

#pragma - mark - UITextFieldDelegate
- (void)textFieldChanged:(NSNotification *)notification{
     UITextField *textField = notification.object;
    if ([LsMethod isMobile:textField.text]||(_isGetCodeVc&&[LsMethod isCode:textField.text])) {
        _nextBtn.userInteractionEnabled=YES;
        _nextBtn.layer.backgroundColor =LSNavColor.CGColor;
        _nextBtn.tag                   =[textField.text integerValue];
    }else{
        _nextBtn.userInteractionEnabled=NO;
        _nextBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text&&![textField.text isEqualToString:@""]) {
        if ([LsMethod isMobile:textField.text]||(_isGetCodeVc&&[LsMethod isCode:textField.text])) {
            _nextBtn.userInteractionEnabled=YES;
            _nextBtn.layer.backgroundColor =LSNavColor.CGColor;
            _nextBtn.tag                   =[textField.text integerValue];
        }else{
            if (_isGetCodeVc) {
                [LsMethod alertMessage:@"请核对您的验证码" WithTime:1.5];
            }else{
                [LsMethod alertMessage:@"手机号有误，请重新输入" WithTime:1.5];
            }
        }
    }
}

#pragma - mark -  QQ WX 登录
- (void)getAuthWithUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            LsLog(@"QQ uid: %@", resp.uid);
            LsLog(@"QQ openid: %@", resp.openid);
            LsLog(@"QQ unionid: %@", resp.unionId);
            LsLog(@"QQ accessToken: %@", resp.accessToken);
            LsLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            LsLog(@"QQ name: %@", resp.name);
            LsLog(@"QQ iconurl: %@", resp.iconurl);
            LsLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            LsLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            LsLog(@"Wechat uid: %@", resp.uid);
            LsLog(@"Wechat openid: %@", resp.openid);
            LsLog(@"Wechat unionid: %@", resp.unionId);
            LsLog(@"Wechat accessToken: %@", resp.accessToken);
            LsLog(@"Wechat refreshToken: %@", resp.refreshToken);
            LsLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            LsLog(@"Wechat name: %@", resp.name);
            LsLog(@"Wechat iconurl: %@", resp.iconurl);
            LsLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            LsLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)loginSuccess{
    [LSUser_Default setObject:@"yes" forKey:@"didLogin"];
    LsAppDelegate *appdele=(LsAppDelegate*)[UIApplication sharedApplication].delegate ;
    [appdele loadMianTab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
