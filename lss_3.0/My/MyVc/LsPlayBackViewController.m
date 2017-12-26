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
#import "LsLiveDetailModel.h"

@interface LsPlayBackViewController ()<UITableViewDelegate,UITableViewDataSource,RequestDataPlayBackDelegate>

@property (nonatomic,strong)  MBProgressHUD            *hud;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UIView                   *topView;

@end

@implementation LsPlayBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =self.navTitle;
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
}

-(void)loadBaseUI{
    _topView                  =[[UIView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 35*LSScale)];
    _topView.backgroundColor  =[UIColor whiteColor];
    [superView addSubview:_topView];
    
    UILabel  *label           =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 0, LSMainScreenW-10*LSScale, CGRectGetHeight(_topView.frame))];
    label.text                =[NSString stringWithFormat:@"回放列表(%lu节)",(unsigned long)self.livevideos.count];
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
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.livevideos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    LsPlayBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsPlayBackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsCourseArrangementModel *model =self.livevideos[indexPath.row];
    model.title                     =self.navTitle;
    [cell  reloadCellWithData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsCourseArrangementModel *model =self.livevideos[indexPath.row];
    [self toPlayBack:model];
}


#pragma - mark - 回放按钮
-(void)toPlayBack:(LsCourseArrangementModel*)model{
    _hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
    _hud.removeFromSuperViewOnHide = YES;

    PlayParameter *parameter = [[PlayParameter alloc] init];
    parameter.userId = CCLIVE_USERID;
    parameter.roomId =model.recordVideoId;
    parameter.liveid =model.liveId;
    parameter.viewerName = [LsSingleton sharedInstance].user.nickName;
    parameter.token = @"shishuo";
    parameter.security = NO;
    if (![LsMethod haveValue:parameter.viewerName]) {
        parameter.viewerName =@"ios";
    }
    SaveToUserDefaults(PLAYBACK_USERID,CCLIVE_USERID);
    SaveToUserDefaults(PLAYBACK_ROOMID,model.recordVideoId);
    SaveToUserDefaults(PLAYBACK_LIVEID,model.liveId);
    SaveToUserDefaults(PLAYBACK_USERNAME,parameter.viewerName);
    SaveToUserDefaults(PLAYBACK_PASSWORD,@"shishuo");
    
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
