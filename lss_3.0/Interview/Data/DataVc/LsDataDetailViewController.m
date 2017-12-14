//
//  LsDataDetailViewController.m
//  lss
//
//  Created by apple on 2017/10/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsDataDetailViewController.h"
#import "LsDataModel.h"
#import <WebKit/WebKit.h>
@interface LsDataDetailViewController ()<WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)  WKWebView         *webView_;
@property (nonatomic,strong)  LsDataDetailModel *model;
@property (nonatomic,strong)  MBProgressHUD     *hud;

@end

@implementation LsDataDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor    =LSNavColor;
    self.navView.backgroundColor =[UIColor clearColor];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"data_fx"] forState:0];
    [self.navView.rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *collectionBtn      =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.navView.rightButton.frame)-35, 24, 36, 35 )];
    [collectionBtn setImage:[UIImage imageNamed:@"data_sc"] forState:0];
    [collectionBtn setImage:[UIImage imageNamed:@"data_sc_dl"] forState:UIControlStateSelected];
    collectionBtn.tag            =110086;
    [collectionBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:collectionBtn];
    [superView addSubview:self.webView_];
    [superView bringSubviewToFront:self.navView];

    if (self.isBanner) {
        self.navView.backgroundColor =LSNavColor;
        self.navView.navTitle        =@"良师快讯";
        self.webView_.frame=CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame));

        NSURLRequest *request =[NSURLRequest requestWithURL:self.bannerUrl];
//        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        [self.webView_ loadRequest:request];
    }else{
        [self getData];
    }
}

-(void)clickRightButton:(UIButton *)btn{
    if (btn.tag==110086) {
        btn.selected  =YES;
        [LsMethod alertMessage:@"收藏" WithTime:1.5];
    }else{
        [LsMethod alertMessage:@"分享" WithTime:1.5];
    }
}

-(void)getData{
    NSDictionary *dict =@{@"infoid":self.code};
    [[LsAFNetWorkTool shareManger] LSPOST:@"getinfocontent.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSDictionary *dict =[responseObject objectForKey:@"data"];
        self.model =[LsDataDetailModel yy_modelWithDictionary:dict];
        NSURLRequest *request =[NSURLRequest requestWithURL:self.model.url];
        [self.webView_ loadRequest:request];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
    
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
        _webView_ =[[WKWebView alloc] initWithFrame:CGRectMake(0,10, LSMainScreenW, LSMainScreenH-10)];
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
