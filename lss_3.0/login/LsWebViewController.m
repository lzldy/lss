//
//  LsWebViewController.m
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWebViewController.h"
#import <WebKit/WebKit.h>

@interface LsWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)  WKWebView         *webView_;
@property (nonatomic,strong)  MBProgressHUD     *hud;

@end

@implementation LsWebViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navView.leftButton.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"用户协议";
    [self loadBaseUI];
}

-(void)loadBaseUI{
    [superView addSubview:self.webView_];
    NSURL        *url     =[NSURL URLWithString:@"http://www.liangshiba.com/site/user/user.html"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView_ loadRequest:request];
}

-(void)backBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    _hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
    _hud.mode = MBProgressHUDModeText;
    _hud.labelText =@"加载中···";
    _hud.margin = 20.f;//提示框的高度
    _hud.removeFromSuperViewOnHide = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [_hud setHidden:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [_hud setHidden:YES];
    [LsMethod alertMessage:@"加载熄火了" WithTime:1.5];
}

-(WKWebView *)webView_{
    if (!_webView_) {
        _webView_ =[[WKWebView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
        _webView_.navigationDelegate = self;
        _webView_.backgroundColor    = LSNavColor;
        _webView_.UIDelegate         = self;
    }
    return _webView_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
