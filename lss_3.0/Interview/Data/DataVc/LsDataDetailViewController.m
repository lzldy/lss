//
//  LsDataDetailViewController.m
//  lss
//
//  Created by apple on 2017/10/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsDataDetailViewController.h"
#import "LsDataModel.h"

@interface LsDataDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)  UIWebView         *webView_;
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
    
    UIButton *collectionBtn      =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.navView.rightButton.frame)-44, 20, 44, 44 )];
    [collectionBtn setImage:[UIImage imageNamed:@"data_sc"] forState:0];
    [collectionBtn setImage:[UIImage imageNamed:@"data_sc_dl"] forState:UIControlStateSelected];
    collectionBtn.tag            =110086;
    [collectionBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];

    [self getData];
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
        [superView addSubview:self.webView_];
        [superView bringSubviewToFront:self.navView];
        NSURLRequest *request =[NSURLRequest requestWithURL:self.model.url];
        [self.webView_ loadRequest:request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    _hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
    _hud.mode = MBProgressHUDModeText;
    _hud.labelText =@"加载中···";
    _hud.margin = 20.f;//提示框的高度
    _hud.removeFromSuperViewOnHide = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_hud setHidden:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_hud setHidden:YES];
    [LsMethod alertMessage:@"加载熄火了" WithTime:1.5];
}

-(UIWebView *)webView_{
    if (!_webView_) {
        _webView_ =[[UIWebView alloc] initWithFrame:CGRectMake(0,10, LSMainScreenW, LSMainScreenH-10)];
        _webView_.delegate=self;
    }
    return _webView_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
