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
#import "LSLabel+TextField.h" 

@interface LsLoginViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    int           countTimer ;
    NSTimer       *timer;
    BOOL          didClickCodeBtn;
    LSLabel_TextField        * phoneNumView;
    LSLabel_TextField        * passWordView;
}
@property (nonatomic,strong) UIButton    *nextBtn;//下一步
@property (nonatomic,strong) UILabel     *label;//条款
@property (nonatomic,strong) UIButton    *codeBtn;//验证码

@end

@implementation LsLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor =LSColor(229, 230, 231, 1);
    [superView addSubview:self.navView];
    self.navView.navTitle =@"注册与登录";
    if (_isRegisterVc) {
        self.navView.navTitle =@"注册";
        [self initBaseUIOfGetCode];
    }else{
        if (_isLoginVc) {
            self.navView.navTitle =@"登录";
        }
        [self initBaseUI];
    }
}

-(void)initBaseUIOfGetCode{
    UILabel *phoneLabel                  =[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.navView.frame), 200, 45*LSScale)];
    phoneLabel.text                      =[NSString stringWithFormat:@"您的手机号:%@",_phoneNumber];
    phoneLabel.font                      =[UIFont systemFontOfSize:13];
    phoneLabel.textColor                 =[UIColor darkTextColor];
    [superView addSubview:phoneLabel];
    
    phoneNumView                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneLabel.frame), LSMainScreenW, 45*LSScale)];
    phoneNumView.textField.delegate      =self;
    phoneNumView.dataArray               =@[@"验证码：",@"请输入验证码"];
    [superView addSubview:phoneNumView];

    _codeBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-88-15, 5, 88, 45*LSScale-10)];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.font  =[UIFont systemFontOfSize:15];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getCodeReqest) forControlEvents:UIControlEventTouchUpInside];
    _codeBtn.layer.cornerRadius=5;
    _codeBtn.layer.backgroundColor =LSNavColor.CGColor;
    [phoneNumView addSubview:_codeBtn];
    
    passWordView                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneNumView.frame)+15, LSMainScreenW, 45*LSScale)];
    passWordView.textField.delegate      =self;
    passWordView.dataArray               =@[@"设置密码：",@"请输入密码"];
    passWordView.textField.keyboardType  =UIKeyboardTypeDefault;
    [superView addSubview:passWordView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self loadBottomView];
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
    phoneNumView                               =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, 20+CGRectGetMaxY(self.navView.frame), LSMainScreenW, 45*LSScale)];
    phoneNumView.textField.delegate            =self;
    phoneNumView.dataArray                     =@[@"手机号：",@"请输入您的手机号"];
    [superView addSubview:phoneNumView];
    if (_isLoginVc) {
        phoneNumView.dataArray                 =@[@"密码：",@"请输入您的密码"];
        phoneNumView.textField.secureTextEntry =YES;
        phoneNumView.textField.keyboardType    =UIKeyboardTypeDefault;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self loadBottomView];
}

-(void)loadBottomView{
    _nextBtn    =[[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneNumView.frame)+30, LSMainScreenW-30, 42*LSScale)];
    if (_isRegisterVc) {
        _nextBtn.frame =CGRectMake(15, CGRectGetMaxY(passWordView.frame)+15, LSMainScreenW-30, 42*LSScale);
    }
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font  =[UIFont systemFontOfSize:17.5];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
    _nextBtn.layer.cornerRadius =5;
    [_nextBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.userInteractionEnabled =NO;
    [superView addSubview:_nextBtn];
    
    if (_isLoginVc) {
        UIButton *forgetBtn   =[[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_nextBtn.frame)+8, 100 ,25)];
        forgetBtn.titleLabel.font   =[UIFont systemFontOfSize:15];
        forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [forgetBtn setTitleColor:LSColor(102, 102, 102, 1) forState:UIControlStateNormal];
        [forgetBtn addTarget:self action:@selector(didClickForgotBtn) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:forgetBtn];
    }
    
    if (!_isRegisterVc&&!_isLoginVc) {
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

-(void)didClickForgotBtn{
    LsLog(@"---------didClickForgotBtn--------");
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

-(void)nextStep:(UIButton*)button{
    if (_isRegisterVc) {
        if (didClickCodeBtn) {
            [self registerRequest];
        }else{
            [LsMethod alertMessage:@"请获取验证码" WithTime:2];
        }
    }else if (_isLoginVc){
        [self loginRequest];
    }else{
        [self checkmobileRequest];
    }
}

#pragma - mark - UITextFieldDelegate TextField代理
- (void)textFieldChanged:(NSNotification *)notification{
    if ([LsMethod isMobile:phoneNumView.textField.text]||(_isRegisterVc&&[LsMethod isCode:phoneNumView.textField.text]&&[LsMethod haveValue:passWordView.textField.text])||(_isLoginVc&&[LsMethod haveValue:phoneNumView.textField.text])) {
        [self resetStatusHight:YES];
    }else{
        [self resetStatusHight:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (!_isLoginVc&&!_isRegisterVc) {
        if ([LsMethod isMobile:textField.text]){
            [self resetStatusHight:YES];
        }else if ([LsMethod haveValue:textField.text]){
            [LsMethod alertMessage:@"请核对您的手机号" WithTime:2];
        }
    }
    
    if (_isLoginVc) {
        if ([LsMethod haveValue:textField.text]) {
            [self resetStatusHight:YES];
        }else{
            [LsMethod alertMessage:@"请输入您的密码" WithTime:2];
        }
    }
    
    if (_isRegisterVc) {
        if ([LsMethod isCode:phoneNumView.textField.text]&&[LsMethod haveValue:passWordView.textField.text]) {
            [self resetStatusHight:YES];
        }
    }
}

-(void)resetStatusHight:(BOOL)isYes{
    if (isYes) {
        _nextBtn.userInteractionEnabled=YES;
        _nextBtn.layer.backgroundColor =LSNavColor.CGColor;
    }else{
        _nextBtn.userInteractionEnabled=NO;
        _nextBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
    }
}

#pragma - mark - Net Request 请求接口
-(void)getCodeReqest{
    NSDictionary *dict =@{@"mobile":self.phoneNumber};
    [[LsAFNetWorkTool shareManger] LSGET:@"preregist.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        countTimer                      = 60;
        _codeBtn.userInteractionEnabled =NO;
        didClickCodeBtn                 =YES;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%d秒",countTimer] forState:UIControlStateNormal];
        timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)checkmobileRequest{
    NSDictionary *dict =@{@"mobile":phoneNumView.textField.text};
    [[LsAFNetWorkTool shareManger] LSGET:@"checkmobile.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        LsLoginViewController *loginVc = [[LsLoginViewController alloc] init];
        loginVc.phoneNumber            = phoneNumView.textField.text;
        loginVc.modalPresentationStyle = UIModalPresentationCustom;
        loginVc.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
        
        NSString *rtnCode=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        NSString *rtnMess=[responseObject objectForKey:@"message"];
        
        if ([rtnCode isEqualToString:@"1"]){
            //已
            loginVc.isLoginVc=YES;
        }else if ([rtnCode isEqualToString:@"0"]){
            loginVc.isRegisterVc=YES;
        }else{
            [LsMethod alertMessage:rtnMess WithTime:2];
        }
        [self presentViewController:loginVc animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)loginRequest{
    NSDictionary *dict  =[NSDictionary dictionary];
    if (_isRegisterVc) {
        dict  =@{@"mobile":_phoneNumber,@"password":passWordView.textField.text};
    }else{
        dict  =@{@"mobile":_phoneNumber,@"password":phoneNumView.textField.text};
    }
    [[LsAFNetWorkTool shareManger] LSGET:@"mobilelogin.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSString *token =[responseObject objectForKey:@""];
        [LSUser_Default setObject:token forKey:@"token"];
        if (![LSUser_Default objectForKey:@"didConfig"]) {
            LsConfigureViewController *conVc = [[LsConfigureViewController alloc] init];
            conVc.modalPresentationStyle =UIModalPresentationCustom;
            conVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;
            [self presentViewController:conVc animated:YES completion:nil];
        }else{
            [self loginSuccess];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)registerRequest{
    NSDictionary*dict =@{@"mobile":_phoneNumber,
                         @"password":passWordView.textField.text,
                         @"password2":passWordView.textField.text,
                         @"smscheckcode":phoneNumView.textField.text};
    [[LsAFNetWorkTool shareManger] LSGET:@"registuser.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self loginRequest];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)thirdLoginRequest:(NSDictionary*)data{
    [[LsAFNetWorkTool shareManger] LSPOST:@"umquicklogin.html" parameters:data success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self loginSuccess];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma - mark -  QQ WX 登录
- (void)getAuthWithUserInfoFromQQ{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            NSDictionary *dict =@{@"umsys":@"QQ",@"umuid":resp.uid,@"umname":resp.name,
                                  @"umgender":resp.unionGender,@"umheadurl":resp.iconurl,
                                  @"mchcode":resp.accessToken,@"umdata":resp.originalResponse};
            [self thirdLoginRequest:dict];
        }
    }];
}

- (void)getAuthWithUserInfoFromWechat{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            NSDictionary *dict =@{@"umsys":@"WX",@"umuid":resp.uid,@"umname":resp.name,
                                  @"umgender":resp.unionGender,@"umheadurl":resp.iconurl,
                                  @"mchcode":resp.accessToken,@"umdata":resp.originalResponse};
            [self thirdLoginRequest:dict];
        }
    }];
}

-(void)loginSuccess{
    [LSUser_Default setObject:@"yes" forKey:@"didLogin"];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    LsAppDelegate *appdele=(LsAppDelegate*)[UIApplication sharedApplication].delegate ;
    [appdele loadMianTab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
