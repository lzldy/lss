//
//  LsOneToOneDetailViewController.m
//  lss
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsOneToOneDetailViewController.h"
#import "LSLabel+TextField.h"

@interface LsOneToOneDetailViewController ()
{
    UIButton *mianshou;
    UIButton *xianshang;
    UIButton *hunan;
    UIButton *guangdong;
    UIButton *guizhou;

    LSLabel_TextField  *nameL;
    LSLabel_TextField  *phoneL;
    LSLabel_TextField  *wxL;

    NSString           *catg2;
    NSString           *catg3;
}
@end

@implementation LsOneToOneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isActivity) {
        self.navView.navTitle         =@"专题活动";
    }else{
        self.navView.navTitle         =@"良师一对一";
    }
    superView.backgroundColor     =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    
    UIImage     *backgroundImage =[UIImage imageNamed:@"find_bg"];
    UIImageView *backgroundImageView  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, backgroundImage.size.height/backgroundImage.size.width*LSMainScreenW)];
    backgroundImageView.image         =backgroundImage;
    [superView addSubview:backgroundImageView];
    [superView bringSubviewToFront:self.navView];
    self.navView.backgroundColor  =[UIColor clearColor];
    
    UILabel *label                = [[UILabel alloc] initWithFrame:CGRectMake(25*LSScale , CGRectGetMaxY(self.navView.frame) , 300*LSScale, 60*LSScale)];
    label.numberOfLines           = 0;
    label.textAlignment           =NSTextAlignmentLeft;
    label.textColor               =[UIColor whiteColor];
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为15
    NSString  *testString         =@"";
    [paragraphStyle  setLineSpacing:10*LSScale];
    if (self.isActivity) {
        testString = @"免费预约\n广东教师招聘笔面试全程班";
    }else{
        testString = @"免费预约\n良师智胜教师招聘一对一辅导";
    }
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    [label  setAttributedText:setString];
    [backgroundImageView addSubview:label];
    
    UIView   *backgroundView        =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backgroundImageView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-15*LSScale-CGRectGetMaxY(backgroundImageView.frame))];
    backgroundView.backgroundColor  =[UIColor whiteColor];
    [superView addSubview:backgroundView];
    
    nameL       =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 45*LSScale)];
    nameL.dataArray                 = @[@"姓       名",@"请填写姓名"];
    nameL.textField.textAlignment   = NSTextAlignmentRight;
    nameL.textField.keyboardType    = UIKeyboardTypeDefault;
    nameL.textField.font            = [UIFont systemFontOfSize:15];
    nameL.haveLine                  =YES;
    [backgroundView addSubview:nameL];
    
    phoneL       =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameL.frame), LSMainScreenW, 45*LSScale)];
    phoneL.dataArray                 = @[@"电       话",@"请填写电话"];
    phoneL.textField.textAlignment   = NSTextAlignmentRight;
    phoneL.textField.font            = [UIFont systemFontOfSize:15];
    phoneL.haveLine                  =YES;
    [backgroundView addSubview:phoneL];
    
    wxL       =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneL.frame), LSMainScreenW, 45*LSScale)];
    wxL.dataArray                 = @[@"微       信",@"请填写微信"];
    wxL.textField.textAlignment   = NSTextAlignmentRight;
    wxL.textField.keyboardType    = UIKeyboardTypeDefault;
    wxL.textField.font            = [UIFont systemFontOfSize:15];
    wxL.haveLine                  =YES;
    [backgroundView addSubview:wxL];

    if (!self.isActivity) {
        LSLabel_TextField  *fangshi       =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(wxL.frame), LSMainScreenW, 45*LSScale)];
        fangshi.dataArray                 = @[@"上课方式",@""];
        fangshi.textField.hidden          =YES;
        fangshi.haveLine                  =YES;
        [backgroundView addSubview:fangshi];
        
        mianshou                =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fangshi.label.frame)+10*LSScale, 11*LSScale, 80*LSScale, 23*LSScale)];
        mianshou.backgroundColor          =[UIColor whiteColor];
        [mianshou setTitleColor:[UIColor darkGrayColor] forState:0];
        mianshou.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        mianshou.layer.borderWidth        =0.5*LSScale;
        mianshou.titleLabel.font          =[UIFont systemFontOfSize:12*LSScale];
        [mianshou setTitle:@"面授一对一" forState:0];
        [mianshou addTarget:self action:@selector(clickModeBtn:) forControlEvents:UIControlEventTouchUpInside];
        mianshou.tag                      =1001;
        [fangshi addSubview:mianshou];
        
        xianshang                =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(mianshou.frame)+10*LSScale, 11*LSScale, 80*LSScale, 23*LSScale)];
        xianshang.backgroundColor          =[UIColor whiteColor];
        [xianshang setTitleColor:[UIColor darkGrayColor] forState:0];
        xianshang.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        xianshang.layer.borderWidth        =0.5*LSScale;
        xianshang.titleLabel.font          =[UIFont systemFontOfSize:12*LSScale];
        [xianshang setTitle:@"线上一对一" forState:0];
        [xianshang addTarget:self action:@selector(clickModeBtn:) forControlEvents:UIControlEventTouchUpInside];
        xianshang.tag                      =1002;
        [fangshi addSubview:xianshang];

        LSLabel_TextField  *fenxiao       =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fangshi.frame), LSMainScreenW, 45*LSScale)];
        fenxiao.dataArray                 = @[@"上课分校",@""];
        fenxiao.textField.hidden          =YES;
        fenxiao.haveLine                  =YES;
        [backgroundView addSubview:fenxiao];
        
        hunan                =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fangshi.label.frame)+10*LSScale, 11*LSScale, 50*LSScale, 23*LSScale)];
        hunan.backgroundColor          =[UIColor whiteColor];
        [hunan setTitleColor:[UIColor darkGrayColor] forState:0];
        hunan.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        hunan.layer.borderWidth        =0.5*LSScale;
        hunan.titleLabel.font          =[UIFont systemFontOfSize:12*LSScale];
        [hunan setTitle:@"湖南" forState:0];
        [hunan addTarget:self action:@selector(clickBerkeley:) forControlEvents:UIControlEventTouchUpInside];
        hunan.tag                      =1001;
        [fenxiao addSubview:hunan];
        
        guangdong                =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hunan.frame)+10*LSScale, 11*LSScale, 50*LSScale, 23*LSScale)];
        guangdong.backgroundColor          =[UIColor whiteColor];
        [guangdong setTitleColor:[UIColor darkGrayColor] forState:0];
        guangdong.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        guangdong.layer.borderWidth        =0.5*LSScale;
        guangdong.titleLabel.font          =[UIFont systemFontOfSize:12*LSScale];
        [guangdong setTitle:@"广东" forState:0];
        [guangdong addTarget:self action:@selector(clickBerkeley:) forControlEvents:UIControlEventTouchUpInside];
        guangdong.tag                      =1002;
        [fenxiao addSubview:guangdong];
        
        guizhou                =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(guangdong.frame)+10*LSScale, 11*LSScale, 50*LSScale, 23*LSScale)];
        guizhou.backgroundColor          =[UIColor whiteColor];
        [guizhou setTitleColor:[UIColor darkGrayColor] forState:0];
        guizhou.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        guizhou.layer.borderWidth        =0.5*LSScale;
        guizhou.titleLabel.font          =[UIFont systemFontOfSize:12*LSScale];
        [guizhou setTitle:@"贵州" forState:0];
        [guizhou addTarget:self action:@selector(clickBerkeley:) forControlEvents:UIControlEventTouchUpInside];
        guizhou.tag                      =1003;
        [fenxiao addSubview:guizhou];

    }
    
    UIButton *submitBtn      =[[UIButton alloc] initWithFrame:CGRectMake(0, LSMainScreenH-45*LSScale, LSMainScreenW, 45*LSScale)];
    [submitBtn setTitle:@"提交预约" forState:0];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:0];
    submitBtn.backgroundColor  =LSNavColor;
    submitBtn.titleLabel.font  =[UIFont systemFontOfSize:15.5*LSScale];
    submitBtn.tag            =9098;
    [submitBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:submitBtn];
    
    UIButton  *kefuBtn       =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-60*LSScale-15*LSScale, LSMainScreenH-45*LSScale-10*LSScale-60*LSScale, 60*LSScale, 60*LSScale)];
    [kefuBtn setImage:[UIImage imageNamed:@"find_kf"] forState:0];
    [kefuBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    kefuBtn.tag              =8099;
    [superView addSubview:kefuBtn];
}

-(void)clickBerkeley:(UIButton*)btn{
    [self clearAll];
    if (btn.tag==1001) {
        catg2                          =@"HN";
        hunan.backgroundColor          =LSNavColor;
        hunan.layer.borderWidth        =0;
        [hunan setTitleColor:[UIColor whiteColor] forState:0];
    }else if (btn.tag==1002){
        catg2                          =@"GD";
        guangdong.backgroundColor      =LSNavColor;
        guangdong.layer.borderWidth    =0;
        [guangdong setTitleColor:[UIColor whiteColor] forState:0];
    }else{
        catg2                            =@"GZ";
        guizhou.backgroundColor          =LSNavColor;
        guizhou.layer.borderWidth        =0;
        [guizhou setTitleColor:[UIColor whiteColor] forState:0];
    }
}

-(void)clearAll{
    hunan.backgroundColor          =[UIColor whiteColor];
    hunan.layer.borderColor        =[UIColor darkGrayColor].CGColor;
    hunan.layer.borderWidth        =0.5*LSScale;
    [hunan setTitleColor:[UIColor darkGrayColor] forState:0];
    
    guangdong.backgroundColor          =[UIColor whiteColor];
    guangdong.layer.borderColor        =[UIColor darkGrayColor].CGColor;
    guangdong.layer.borderWidth        =0.5*LSScale;
    [guangdong setTitleColor:[UIColor darkGrayColor] forState:0];
    
    guizhou.backgroundColor          =[UIColor whiteColor];
    guizhou.layer.borderColor        =[UIColor darkGrayColor].CGColor;
    guizhou.layer.borderWidth        =0.5*LSScale;
    [guizhou setTitleColor:[UIColor darkGrayColor] forState:0];
}

-(void)clickModeBtn:(UIButton*)btn{
    if (btn.tag==1001) {
        catg3                             =@"MSYDY";
        mianshou.backgroundColor          =LSNavColor;
        mianshou.layer.borderWidth        =0;
        [mianshou setTitleColor:[UIColor whiteColor] forState:0];

        xianshang.backgroundColor          =[UIColor whiteColor];
        xianshang.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        xianshang.layer.borderWidth        =0.5*LSScale;
        [xianshang setTitleColor:[UIColor darkGrayColor] forState:0];

    }else{
        catg3                             =@"ZXYDY";
        xianshang.backgroundColor          =LSNavColor;
        xianshang.layer.borderWidth        =0;
        [xianshang setTitleColor:[UIColor whiteColor] forState:0];
        
        mianshou.backgroundColor          =[UIColor whiteColor];
        mianshou.layer.borderColor        =[UIColor darkGrayColor].CGColor;
        mianshou.layer.borderWidth        =0.5*LSScale;
        [mianshou setTitleColor:[UIColor darkGrayColor] forState:0];
    }
}

-(void)clickBtn:(UIButton *)button{
    if (button.tag ==8099) {
        [LSApplication openURL:LSCustomerService];
    }else{
        [self submitOrder];
    }
}

-(void)submitOrder{
    
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    
    if (!self.isActivity) {
        [dict setObject:@"13" forKey:@"infoid"];
    }else{
        [dict setObject:self.ID forKey:@"infoid"];
    }
    
    if (![LsMethod haveValue:nameL.textField.text]) {
        [LsMethod alertMessage:@"请输入您的姓名" WithTime:1.5];
        return;
    }else{
        [dict setObject:nameL.textField.text forKey:@"name"];
    }
    
    if (![LsMethod haveValue:phoneL.textField.text]) {
        [LsMethod alertMessage:@"请填写您的联系方式" WithTime:1.5];
        return;
    }else{
        [dict setObject:phoneL.textField.text forKey:@"mobile"];
    }
    
    if (![LsMethod haveValue:wxL.textField.text]) {
        [LsMethod alertMessage:@"请填写您的联系方式" WithTime:1.5];
        return;
    }else{
        [dict setObject:wxL.textField.text forKey:@"wechat"];
    }
    if (!self.isActivity) {
        if ([LsMethod haveValue:catg3]) {
            [dict setObject:catg3 forKey:@"catg3"];
        }else{
            [LsMethod alertMessage:@"请选择上课方式" WithTime:1.5];
            return;
        }
        if ([LsMethod haveValue:catg2]) {
            [dict setObject:catg2 forKey:@"catg2"];// ZXYDY  MSYDY
        }else{
            [LsMethod alertMessage:@"请选择上课分校" WithTime:1.5];
            return;
        }
    }
    [[LsAFNetWorkTool shareManger] LSPOST:@"signcampaign.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [LsMethod alertMessage:@"恭喜您,报名成功" WithTime:1.5];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
