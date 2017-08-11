//
//  AppDelegate.m
//  lss_3.0
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#define UM_APPKEY  @"58abfe578f4a9d126f0003bd"

#import "LsAppDelegate.h"
#import "LsTabBarViewController.h"
#import "LsLoginViewController.h"
#import "LsGuidePageViewController.h"
#import "LsConfigureViewController.h"

static NSString* WXAppid = @"wx5231d4d655cbf5c2";
static NSString* WXSecret = @"875777926699ad7f9a0ad7675dfe2011";

static NSString* QQAppid = @"1105807406";
static NSString* QQSecret = @"IIwxLqdIAdZGG6R3";

static NSString* WBAppid = @"2862859337";
static NSString* WBSecret = @"06f988828740fee943633953dcf73ba3";

@interface LsAppDelegate ()

@end

@implementation LsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window =[[UIWindow alloc] initWithFrame:LSMainScreen];
    [LsAFNetWorkTool monitorNet];
#ifdef DEBUG_MODE
    [self testGuideVc];
#endif
    [self initUM];
    [self loadRootVc];
    [self setIQKeyboard];
    [self.window makeKeyAndVisible];
  
    return YES;
}

-(void)initUM{
    /* 打开调试日志 */
#ifdef DEBUG_MODE
    [[UMSocialManager defaultManager] openLog:YES];
#endif
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    //WX
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppid appSecret:WXSecret redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WXAppid appSecret:WXSecret redirectURL:nil];
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppid appSecret:QQSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:QQAppid appSecret:QQSecret redirectURL:@"http://mobile.umeng.com/social"];
    //WB
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAppid  appSecret:WBSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
       /* 支付宝的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];
    
}


-(void)testGuideVc{
    [LSUser_Default removeObjectForKey:@"didGuide"];
    [LSUser_Default removeObjectForKey:@"didLogin"];
    [LSUser_Default removeObjectForKey:@"didConfig"];
//    [LSUser_Default setObject:@"yes" forKey:@"didGuide"];
//    [LSUser_Default setObject:@"yes" forKey:@"didLogin"];
//    [LSUser_Default setObject:@"yes" forKey:@"didConfig"];
//    static NSString* QQAppid = @"1105807406";
//    static NSString* QQSecret = @"IIwxLqdIAdZGG6R3";
}

-(void)loadRootVc{
    if (![LSUser_Default objectForKey:@"didGuide"]) {
        [self loadGuideVc];
    }else{
        if (![LSUser_Default objectForKey:@"didLogin"]) {
            [self loadLoginVc];
        }else{
            [self loadMianTab];
        }
    }
}

-(void)loadMianTab{
    LsTabBarViewController *tab =[[LsTabBarViewController alloc] init];
    self.window.rootViewController =tab;
}

-(void)loadGuideVc{
    LsGuidePageViewController *guideVc = [[LsGuidePageViewController alloc] init];
    guideVc.modalPresentationStyle =UIModalPresentationCustom;
    guideVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;//渐隐渐现
    self.window.rootViewController =guideVc;
}

-(void)loadLoginVc{
    LsLoginViewController *loginVc = [[LsLoginViewController alloc] init];
    loginVc.modalPresentationStyle =UIModalPresentationCustom;
    loginVc.modalTransitionStyle   =UIModalTransitionStyleCrossDissolve;//渐隐渐现
    self.window.rootViewController =loginVc;
}

-(void)setIQKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
