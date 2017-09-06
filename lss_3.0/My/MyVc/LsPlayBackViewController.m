//
//  LsPlayBackViewController.m
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPlayBackViewController.h"
#import "PlayBackVC.h"
#import "CCSDK/CCLiveUtil.h"
#import "CCSDK/RequestDataPlayBack.h"
#import "LsPlayBackTableViewCell.h"

@interface LsPlayBackViewController ()<UITableViewDelegate,UITableViewDataSource,RequestDataPlayBackDelegate>

@property (nonatomic,strong)  MBProgressHUD            *hud;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UIView                   *topView;

@end

@implementation LsPlayBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =_model.title;
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    _topView                  =[[UIView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 35*LSScale)];
    _topView.backgroundColor  =[UIColor whiteColor];
    [superView addSubview:_topView];
    
    UILabel  *label           =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 0, LSMainScreenW-10*LSScale, CGRectGetHeight(_topView.frame))];
    label.text                =@"回放列表(3节)";
    label.font                =[UIFont systemFontOfSize:14*LSScale];
    label.textColor           =[UIColor darkGrayColor];
    label.textAlignment       =NSTextAlignmentLeft;
    [_topView addSubview:label];
    
    UIView *line              =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_topView.frame)-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
    line.backgroundColor      =LSLineColor;
    [_topView addSubview:line];
    
    [superView addSubview:self.tabView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    LsPlayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsPlayBackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell  reloadCellWithData:_model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self toPlayBack];
}


#pragma - mark - 回放按钮
-(void)toPlayBack{
    _hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
    _hud.removeFromSuperViewOnHide = YES;

    PlayParameter *parameter = [[PlayParameter alloc] init];
    parameter.userId = CCLIVE_USERID;
    parameter.roomId =@"85339BECF4BA03FA9C33DC5901307461";
    parameter.liveid = @"7E4226D46FD192E8";
    parameter.viewerName = @"唐朝将军";
    parameter.token = @"shishuo";
    parameter.security = NO;
    RequestDataPlayBack *requestDataPlayBack = [[RequestDataPlayBack alloc] initLoginWithParameter:parameter];
    requestDataPlayBack.delegate = self;
}

-(void)loginSucceedPlayBack {
    [_hud hide:YES];
    LSApplication.idleTimerDisabled=YES;
    PlayBackVC *playBackVC = [[PlayBackVC alloc] init];
    [self presentViewController:playBackVC animated:YES completion:nil];
}

-(void)loginFailed:(NSError *)error reason:(NSString *)reason {
    [_hud hide:YES];
    
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    [LsMethod alertMessage:message WithTime:2];
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.topView.frame))];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
    }
    return _tabView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
