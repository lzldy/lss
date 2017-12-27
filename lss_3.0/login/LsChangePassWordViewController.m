//
//  LsChangePassWordViewController.m
//  lss
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsChangePassWordViewController.h"
#import "LSLabel+TextField.h"

@interface LsChangePassWordViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    int           countTimer ;
    NSTimer       *timer;
    BOOL          didClickCodeBtn;
    LSLabel_TextField        * phoneNumView;
    LSLabel_TextField        * codeView;
    LSLabel_TextField        * passWordView;
    LSLabel_TextField        * passWordView2;
}
@property (nonatomic,strong) UIButton    *nextBtn;//下一步
@property (nonatomic,strong) UIButton    *codeBtn;//验证码

@end

@implementation LsChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"修改密码";
    superView.backgroundColor =LSColor(229, 230, 231, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    phoneNumView                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+10*LSScale, LSMainScreenW, 45*LSScale)];
    phoneNumView.textField.delegate      =self;
    phoneNumView.dataArray               =@[@"手机号：",@"请输入您的手机号"];
    phoneNumView.textField.keyboardType  =UIKeyboardTypePhonePad;
    [superView addSubview:phoneNumView];
    
    codeView                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneNumView.frame)+10*LSScale, LSMainScreenW, 45*LSScale)];
    codeView.textField.delegate      =self;
    codeView.textField.keyboardType  =UIKeyboardTypeNumberPad;
    codeView.dataArray               =@[@"验证码：",@"请输入验证码"];
    [superView addSubview:codeView];
    
    _codeBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-88-15, 5, 88, 45*LSScale-10)];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBtn.titleLabel.font  =[UIFont systemFontOfSize:15];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getCodeReqest) forControlEvents:UIControlEventTouchUpInside];
    _codeBtn.layer.cornerRadius=5;
    _codeBtn.layer.backgroundColor =LSNavColor.CGColor;
    [codeView addSubview:_codeBtn];
    
    passWordView                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(codeView.frame)+10*LSScale, LSMainScreenW, 45*LSScale)];
    passWordView.textField.delegate      =self;
    passWordView.dataArray               =@[@"设置密码：",@"请输入密码"];
    passWordView.textField.keyboardType  =UIKeyboardTypeDefault;
    [superView addSubview:passWordView];
    
    passWordView2                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(passWordView.frame)+10*LSScale, LSMainScreenW, 45*LSScale)];
    passWordView2.textField.delegate      =self;
    passWordView2.dataArray               =@[@"设置密码：",@"请在此输入密码"];
    passWordView2.textField.keyboardType  =UIKeyboardTypeDefault;
    [superView addSubview:passWordView2];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self loadBottomView];
}

-(void)loadBottomView{
    _nextBtn    =[[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(passWordView2.frame)+30*LSScale, LSMainScreenW-30, 42*LSScale)];
    [_nextBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font  =[UIFont systemFontOfSize:17.5];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
    _nextBtn.layer.cornerRadius =5;
    [_nextBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.userInteractionEnabled =NO;
    [superView addSubview:_nextBtn];
}

#pragma - mark - Net Request 请求接口
-(void)getCodeReqest{
    if (![LsMethod haveValue:phoneNumView.textField.text]) {
        [LsMethod alertMessage:@"请先输入您的手机号" WithTime:1.5];
        return;
    }
    NSDictionary *dict =@{@"mobile":phoneNumView.textField.text,@"opmode":@"CHPS"};
    [[LsAFNetWorkTool shareManger] LSGET:@"preregist.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        countTimer                      = 60;
        _codeBtn.userInteractionEnabled =NO;
        didClickCodeBtn                 =YES;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%d秒",countTimer] forState:UIControlStateNormal];
        timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
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

-(void)nextStep:(UIButton*)button{
    if ([passWordView.textField.text isEqualToString:passWordView2.textField.text]) {
        [self changePassWordRequest];
    }else{
        [LsMethod alertMessage:@"您两次输入的密码不一致" WithTime:1.5];
    }
}

-(void)changePassWordRequest{
    NSDictionary  *dict  =@{@"mobile"     :phoneNumView.textField.text,
                            @"smscode"    :codeView.textField.text,
                            @"password"   :passWordView.textField.text,
                            @"password2"  :passWordView2.textField.text};
    [[LsAFNetWorkTool shareManger] LSPOST:@"changepass.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [LsMethod alertMessage:@"密码修改成功" WithTime:1.5];
        [LSUser_Default setObject:@"yes" forKey:@"didLogin"];
        if (self.isForgot) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma - mark - UITextFieldDelegate TextField代理
//- (void)textFieldChanged:(NSNotification *)notification{
//
//}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (![LsMethod haveValue:phoneNumView.textField.text]&&textField==phoneNumView.textField){
        [LsMethod alertMessage:@"请核对您的手机号" WithTime:1.5];
    }
    if (![LsMethod haveValue:codeView.textField.text]&&textField==codeView.textField){
        [LsMethod alertMessage:@"请输入验证码" WithTime:1.5];
    }
    if (![LsMethod haveValue:passWordView.textField.text]&&textField==passWordView.textField){
        [LsMethod alertMessage:@"请输入您要修改的密码" WithTime:1.5];
    }
    if (![LsMethod haveValue:passWordView2.textField.text]&&textField==passWordView2.textField){
        [LsMethod alertMessage:@"请再次输入您要修改的密码" WithTime:1.5];
    }
    if ([LsMethod haveValue:phoneNumView.textField.text]&&[LsMethod haveValue:codeView.textField.text]&&[LsMethod haveValue:passWordView.textField.text]&&[LsMethod haveValue:passWordView2.textField.text]) {
        _nextBtn.userInteractionEnabled =YES;
        _nextBtn.layer.backgroundColor  =LSNavColor.CGColor;
    }else{
        _nextBtn.userInteractionEnabled =NO;
        _nextBtn.layer.backgroundColor  =LSColor(169, 170, 171, 1).CGColor;
    }
 
}

//-(void)resetStatusHight:(BOOL)isYes{
//    if (isYes) {
//        _nextBtn.userInteractionEnabled=YES;
//        _nextBtn.layer.backgroundColor =LSNavColor.CGColor;
//    }else{
//        _nextBtn.userInteractionEnabled=NO;
//        _nextBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
