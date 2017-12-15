//
//  LsFeedBackViewController.m
//  lss
//
//  Created by apple on 2017/12/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsFeedBackViewController.h"

@interface LsFeedBackViewController ()<UITextViewDelegate>
{
    UITextView  *textView_;
}
@end

@implementation LsFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"意见反馈";
    [self loadBaseUI];
    // Do any additional setup after loading the view.
}

-(void)loadBaseUI{
    textView_=[[UITextView alloc]initWithFrame:CGRectMake(15*LSScale,25*LSScale+CGRectGetMaxY(self.navView.frame), LSMainScreenW-30*LSScale, 185*LSScale)];
    textView_.delegate=self;
    textView_.layer.borderColor=LSNavColor.CGColor;
    textView_.layer.borderWidth=1*LSScale;
    textView_.returnKeyType =UIReturnKeyDone;//返回键的类型
    textView_.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView_.text=@" 在这里写下您的宝贵意见~~~";
    textView_.font = [UIFont systemFontOfSize:15*LSScale];
    textView_.textColor   =LSColor(102, 102, 102, 1);
    [superView addSubview:textView_];
    
    UIButton  *submitBtn   =[[UIButton alloc]  initWithFrame:CGRectMake(45*LSScale, CGRectGetMaxY(textView_.frame)+18*LSScale, LSMainScreenW-90*LSScale, 42*LSScale)];
    submitBtn.layer.cornerRadius   =10*LSScale;
    submitBtn.layer.backgroundColor =LSNavColor.CGColor;
    [submitBtn setTitle:@"提交意见" forState:0];
    [submitBtn addTarget:self action:@selector(submitFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:submitBtn];
}

-(void)submitFeedBack{
    if ([LsMethod haveValue:textView_.text]&&![textView_.text isEqualToString:@" 在这里写下您的宝贵意见~~~"]) {
        NSDictionary  *dict =@{@"content":textView_.text};
        [[LsAFNetWorkTool shareManger] LSPOST:@"addfeedback.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            [LsMethod alertMessage:@"良师说感谢您的反馈~~~" WithTime:1.5];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        }];
    }else{
        [LsMethod alertMessage:@"请填写您的宝贵意见~~~" WithTime:1.5];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (![LsMethod haveValue:textView_.text]||[textView_.text isEqualToString:@" 在这里写下您的宝贵意见~~~"]) {
        textView_.text        =@"  ";
    }
    textView_.textColor   =[UIColor darkTextColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (![LsMethod haveValue:textView_.text]) {
        textView_.textColor   =LSColor(102, 102, 102, 1);
        textView_.text=@" 在这里写下您的宝贵意见~~~";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
