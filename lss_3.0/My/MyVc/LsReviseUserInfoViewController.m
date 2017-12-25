//
//  LsReviseUserInfoViewController.m
//  lss
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsReviseUserInfoViewController.h"
#import "LsConfigureViewController.h"
#import "LsLoginViewController.h"
#import "LSLabel+TextField.h"
#import "LsChangePassWordViewController.h"

@interface LsReviseUserInfoViewController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    LSLabel_TextField *nameL;
    UIButton          *manBtn;
    UIButton          *womanBtn;
    
    NSString          *nickname;//昵称
    NSString          *gender;//性别
    NSString          *memo;//备注
    NSString          *face;//头像

    UIImageView       *headerImageV;
    UIImage           *headerImage;
    UILabel           *phoneL;
    UILabel           *nameLabel;
}

@property (nonatomic,strong) UIImagePickerController *imagePickerController;

@end

@implementation LsReviseUserInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    headerImage        =LOADIMAGE(@"touxiang_icon");
    [headerImageV sd_setImageWithURL:[LsSingleton sharedInstance].user.face placeholderImage:headerImage];
    if ([LsSingleton sharedInstance].user.mobile) {
        phoneL.text           =[LsSingleton sharedInstance].user.mobile;
    }else{
        phoneL.text           =@"手机号";
    }
    
    if ([LsSingleton sharedInstance].user.nickName) {
        nameLabel.text           =[LsSingleton sharedInstance].user.nickName;
    }else{
        nameLabel.text           =@"姓名";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

-(void)loadBaseUI{
    if (self.isDetailRevise) {
        self.navView.navTitle = @"修改信息";
        [self.navView.rightButton setTitle:@"保存" forState:0];
        [self.navView.rightButton addTarget:self action:@selector(reviseUserInfoBtn) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.navView.navTitle = @"个人信息";
        [self.navView.rightButton setImage:LOADIMAGE(@"xiugai") forState:0];
        [self.navView.rightButton addTarget:self action:@selector(reviseUserInfoBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImage     *image      =LOADIMAGE(@"bj_icon");
    UIImageView *backImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW,LSMainScreenW/image.size.width*image.size.height)];
    backImageV.image        =image;
    [superView addSubview:backImageV];
    
    headerImageV       =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-75*LSScale, CGRectGetMaxY(self.navView.frame)+20*LSScale, 70*LSScale,70*LSScale)];
    headerImageV.layer.cornerRadius =35*LSScale;
    headerImageV.layer.masksToBounds=YES;
    [headerImageV sd_setImageWithURL:[LsSingleton sharedInstance].user.face placeholderImage:headerImage];

    [superView addSubview:headerImageV];
    
    UILabel  *label      =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(backImageV.frame)+10*LSScale, LSMainScreenW-30*LSScale, 30*LSScale)];
    label.textAlignment  =NSTextAlignmentLeft;
    label.textColor      =[UIColor darkGrayColor];
    [superView addSubview:label];
    
    if (self.isDetailRevise) {
        headerImageV.frame      =CGRectMake(LSMainScreenW/2-35*LSScale,CGRectGetMaxY(self.navView.frame)+20*LSScale, 70*LSScale, 70*LSScale);
        UIButton   *headerBtn   =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW/2-80*LSScale, CGRectGetMaxY(headerImageV.frame)+5*LSScale, 160*LSScale, 30*LSScale)];
        [headerBtn setTitle:@"点击上传头像" forState:0];
        [headerBtn setTitleColor:[UIColor whiteColor] forState:0];
        [headerBtn addTarget:self action:@selector(handleSingleTapFrom) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:headerBtn];
        
        label.text           =@"完善资料让自己变得倾国倾城！";

        nameL                         =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(label.frame)+3*LSScale, LSMainScreenW, 45*LSScale)];
        nameL.textField.delegate      =self;
        nameL.label.textColor         =[UIColor darkGrayColor];
        nameL.dataArray               =@[@"姓别：",@"请输入姓名"];
        nameL.textField.keyboardType  =UIKeyboardTypeDefault;
        nameL.textField.textColor     =[UIColor darkGrayColor];
        [superView addSubview:nameL];
        
//        genderL
        LSLabel_TextField *genderL      =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(nameL.frame)+5*LSScale, LSMainScreenW, 45*LSScale)];
        genderL.label.textColor         =[UIColor darkGrayColor];
        genderL.dataArray               =@[@"姓名：",@""];
        genderL.textField.hidden        =YES;
        [superView addSubview:genderL];
        
        manBtn               =[[UIButton alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(genderL.label.frame)+20*LSScale,  CGRectGetMaxY(nameL.frame)+5*LSScale, 50*LSScale, 45*LSScale)];
        [manBtn setTitle:@"男" forState:0];
        [manBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        [manBtn addTarget:self action:@selector(clickGenderBtn:) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:manBtn];
        
        womanBtn               =[[UIButton alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(manBtn.frame),  CGRectGetMaxY(nameL.frame)+5*LSScale, 50*LSScale, 45*LSScale)];
        [womanBtn setTitle:@"女" forState:0];
        [womanBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        [womanBtn addTarget:self action:@selector(clickGenderBtn:) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:womanBtn];
        
        
        LSLabel_TextField *memoL      =[[LSLabel_TextField alloc] initWithFrame:CGRectMake(30*LSScale, CGRectGetMaxY(genderL.frame)+5*LSScale, LSMainScreenW, 45*LSScale)];
        memoL.label.textColor         =[UIColor darkGrayColor];
        memoL.dataArray               =@[@"签名：",@""];
        memoL.textField.hidden        =YES;
        [superView addSubview:memoL];
        
        UITextView * textView_=[[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(memoL.label.frame)+30*LSScale,CGRectGetMaxY(genderL.frame)+12*LSScale, LSMainScreenW-60*LSScale-CGRectGetMaxX(memoL.label.frame), 120*LSScale)];
        textView_.delegate=self;
        textView_.layer.cornerRadius=3*LSScale;
        textView_.layer.borderColor=LSNavColor.CGColor;
        textView_.layer.borderWidth=1*LSScale;
        textView_.returnKeyType =UIReturnKeyDone;//返回键的类型
        textView_.keyboardType = UIKeyboardTypeDefault;//键盘类型
        textView_.text=@" 留下属于自己的签名~~~";
        textView_.font = [UIFont systemFontOfSize:15*LSScale];
        textView_.textColor   =LSColor(102, 102, 102, 1);
        [superView addSubview:textView_];
        
    }else{
        
        phoneL      =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW/2+5*LSScale, CGRectGetMidY(headerImageV.frame)-20*LSScale, LSMainScreenW/2, 20*LSScale)];
        phoneL.textAlignment  =NSTextAlignmentLeft;
        if ([LsSingleton sharedInstance].user.mobile) {
            phoneL.text           =[LsSingleton sharedInstance].user.mobile;
        }else{
            phoneL.text           =@"手机号";
        }
        phoneL.textColor      =[UIColor whiteColor];
        [superView addSubview:phoneL];
        
        nameLabel      =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW/2+5*LSScale, CGRectGetMidY(headerImageV.frame), LSMainScreenW/2, 20*LSScale)];
        nameLabel.textAlignment  =NSTextAlignmentLeft;
        if ([LsSingleton sharedInstance].user.nickName) {
            nameLabel.text           =[LsSingleton sharedInstance].user.nickName;
        }else{
            nameLabel.text           =@"姓名";
        }
        nameLabel.textColor      =[UIColor whiteColor];
        [superView addSubview:nameLabel];
        
        label.text           =@"我的属性配置";
        
        NSMutableArray *array  =[NSMutableArray array];
        if ([LsMethod haveValue:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"项目"]]) {
            [array addObject:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"项目"]];
        }
        if ([LsMethod haveValue:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"学段"]]) {
            [array addObject:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"学段"]];
        }
        if ([LsMethod haveValue:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"科目"]]) {
            [array addObject:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"科目"]];
        }else{
            
        }
        if ([LsMethod haveValue:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"分校"]]) {
            [array addObject:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"分校"]];
        }
        
        UILabel *btn =[[UILabel alloc] init];
        for (int i=0; i<array.count; i++) {
            CGSize  size  =[LsMethod sizeWithString:array[i] font:[UIFont systemFontOfSize:13*LSScale]];
            UILabel  *labelL  =[[UILabel alloc] init];
            labelL.frame =CGRectMake(10*LSScale+CGRectGetMaxX(btn.frame), CGRectGetMaxY(label.frame)+5*LSScale, size.width+30*LSScale, 25*LSScale);
            labelL.text  =array[i];
            labelL.textAlignment  =NSTextAlignmentCenter;
            labelL.font  =[UIFont systemFontOfSize:13*LSScale];
            labelL.textColor =[UIColor whiteColor];
            labelL.layer.cornerRadius  =12.5*LSScale;
            labelL.layer.backgroundColor =LSNavColor.CGColor;
            
            btn.frame =labelL.frame;
            
            [superView addSubview:labelL];
        }
        
        NSString   *str  =@"修改我的属性配置";
        CGSize     size  =[LsMethod sizeWithString:str font:[UIFont systemFontOfSize:14*LSScale]];
        UIButton  *changeBtn  =[[UIButton alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(btn.frame)+10*LSScale, size.width, 25*LSScale)];
        changeBtn.titleLabel.font  =[UIFont systemFontOfSize:14*LSScale];
        [changeBtn setTitle:str forState:0];
        [changeBtn setTitleColor:LSNavColor forState:0];
        [changeBtn addTarget:self action:@selector(clickChangeBtn) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:changeBtn];
        
        UIButton  *logoutBtn  =[[UIButton alloc] initWithFrame:CGRectMake(15*LSScale, LSMainScreenH-30*LSScale-30*LSScale,LSMainScreenW-30*LSScale, 30*LSScale)];
        logoutBtn.titleLabel.font  =[UIFont systemFontOfSize:15*LSScale];
        [logoutBtn setTitle:@"退出" forState:0];
        [logoutBtn setTitleColor:LSNavColor forState:0];
        [logoutBtn addTarget:self action:@selector(clickLogoutBtn) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:logoutBtn];
        
        if (![[LSUser_Default objectForKey:@"thirdLogin"] isEqualToString:@"yes"]) {
            UIButton  *passwordBtn  =[[UIButton alloc] initWithFrame:CGRectMake(50*LSScale, CGRectGetMinY(logoutBtn.frame)-50*LSScale,LSMainScreenW-100*LSScale, 32*LSScale)];
            passwordBtn.titleLabel.font  =[UIFont systemFontOfSize:14*LSScale];
            [passwordBtn setTitle:@"修改密码" forState:0];
            [passwordBtn setTitleColor:[UIColor whiteColor] forState:0];
            passwordBtn.layer.cornerRadius   =10*LSScale;
            passwordBtn.layer.backgroundColor =LSNavColor.CGColor;
            [passwordBtn addTarget:self action:@selector(clickpasswordBtn) forControlEvents:UIControlEventTouchUpInside];
            [superView addSubview:passwordBtn];
        }
    }
}

-(void)clickGenderBtn:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"男"]) {
        gender    =@"M";
        [manBtn   setTitleColor:LSNavColor forState:0];
        [womanBtn setTitleColor:[UIColor darkGrayColor] forState:0];
    }else{
        gender    =@"F";
        [manBtn   setTitleColor:[UIColor darkGrayColor] forState:0];
        [womanBtn setTitleColor:LSNavColor forState:0];
    }
}

-(void)clickLogoutBtn{
    [[LsAFNetWorkTool shareManger] LSPOST:@"logout.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self toLoginVc];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)toLoginVc{
    NSString*appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [LSUser_Default removePersistentDomainForName:appDomain];
    
    LsLoginViewController *loginVc = [[LsLoginViewController alloc] init];
    loginVc.modalPresentationStyle =UIModalPresentationCustom;
    loginVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;//渐隐渐现
    LSApplicationDelegate.window.rootViewController =loginVc;
}

-(void)clickpasswordBtn{
    LsChangePassWordViewController *vc =[[LsChangePassWordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickChangeBtn{
    LsConfigureViewController *vc =[[LsConfigureViewController alloc] init];
    [self.navigationController  pushViewController:vc animated:YES];
}

-(void)uploadHeaderIcon:(NSData*)data{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    
    //用AFN的AFHTTPSessionManager
    AFHTTPSessionManager *sharedManager = [[AFHTTPSessionManager alloc]init];
    sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    sharedManager.requestSerializer.timeoutInterval =30;
    NSString *url = [NSString stringWithFormat:@"http://api.iyoukiss.com/uploadimgfile.html"];
    [sharedManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传数据:FileData-->data  name-->fileName(固定，和服务器一致)  fileName-->你的文件名  mimeType-->我的语音文件type是audio/amr 如果你是图片可能为image/jpeg
        NSString *str       =@"headerImage";
        NSString * fileName = [str stringByAppendingString:[NSString stringWithFormat:@"%ld.jpg",(long)[[NSDate date] timeIntervalSince1970]]];

        [formData appendPartWithFileData:data name:@"imgfile" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [hud hide:YES];
        face = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
        UIImage     *headerImage        =LOADIMAGE(@"touxiang_icon");
        [headerImageV sd_setImageWithURL:[NSURL URLWithString:face] placeholderImage:headerImage];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hide:YES];
        [LsMethod alertMessage:error.localizedDescription WithTime:1.5];
    }];
}

-(void)handleSingleTapFrom{
    UIActionSheet *sheet;
    sheet.actionSheetStyle=UIActionSheetStyleDefault;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        sheet.tag = 119;
    }else{
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        sheet.tag = 120;
    }
    sheet.delegate=self;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 119)
    {
        switch (buttonIndex)
        {
            case 0:
                [self TypeCamera];
                break;
            case 1:
                [self TypePhotoLibrary];
                break;
            default:
                break;
        }
    }else{
        switch (buttonIndex)
        {
            case 0:
                [self TypePhotoLibrary];
                break;
            default:
                break;
        }
    }
}

-(void)TypeCamera{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

-(void)TypePhotoLibrary{
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    self.imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image        = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *data          = UIImageJPEGRepresentation(image, 1.0f);
    [self uploadHeaderIcon:data];
  
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)reviseUserInfoBtn{
    if (self.isDetailRevise) {
        [self saveUesrInfo];
    }else{
        LsReviseUserInfoViewController *vc =[[LsReviseUserInfoViewController alloc] init];
        vc.isDetailRevise                  =YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)saveUesrInfo{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if ([LsMethod haveValue:nickname]) {
        [dict setObject:nickname forKey:@"nickname"];
    }
    if ([LsMethod haveValue:gender]) {
        [dict setObject:gender forKey:@"sex"];
    }
    if ([LsMethod haveValue:memo]) {
        [dict setObject:memo forKey:@"memo"];
    }
    if ([LsMethod haveValue:face]) {
        [dict setObject:face forKey:@"face"];
    }
    
    if (dict.count!=0) {
        [[LsAFNetWorkTool shareManger]  LSPOST:@"updateuser.html" parameters:dict success:^(NSURLSessionDataTask * task, id responseObject) {
            [LsMethod alertMessage:@"更新成功" WithTime:1.5];
            [self getUserInfo];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        }];
    }
}

-(void)getUserInfo{
    [[LsAFNetWorkTool shareManger]  LSPOST:@"getusersetting.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [[LsSingleton sharedInstance]  yy_modelSetWithJSON:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([LsMethod haveValue:textField.text]) {
        nickname  =textField.text;
    }else{
        [LsMethod alertMessage:@"请输入您的姓名" WithTime:1.5];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (![LsMethod haveValue:textView.text]||[textView.text isEqualToString:@" 留下属于自己的签名~~~"]) {
        textView.text        =@"";
    }
    textView.textColor   =[UIColor darkGrayColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (![LsMethod haveValue:textView.text]) {
        textView.textColor   =LSColor(102, 102, 102, 1);
        textView.text=@" 留下属于自己的签名~~~";
    }
    memo  =textView.text;
}

-(UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController =[[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
