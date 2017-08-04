//
//  LsLoginViewController.m
//  lss
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLoginViewController.h"
#import "LsTabBarViewController.h"

@interface LsLoginViewController ()

@end

@implementation LsLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadQQAndWXView];
}

-(void)loadQQAndWXView{
    UIButton *qqBtn =[[UIButton alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    qqBtn.backgroundColor=[UIColor redColor];
    [qqBtn addTarget:self action:@selector(getAuthWithUserInfoFromQQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    UIButton *wxBtn =[[UIButton alloc] initWithFrame:CGRectMake(120, 30, 50, 50)];
    wxBtn.backgroundColor=[UIColor redColor];
    [wxBtn addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
}

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
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


-(void)loginSuccess{
    [LSUser_Default setObject:@"yes" forKey:@"didLogin"];
    LsAppDelegate *appdele=(LsAppDelegate*)[UIApplication sharedApplication].delegate ;
    LsTabBarViewController *tab =[[LsTabBarViewController alloc] init];
    [tab setSelectedIndex:1];
    appdele.window.rootViewController=tab;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
