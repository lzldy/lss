//
//  LsMyLiveListViewController.m
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyLiveListViewController.h"
#import "LsLiveTableViewCell.h"
#import "LsMyLiveModel.h"
#import "LsMyLiveTabView.h"
#import "LsLiveDetailViewController.h"
#import "LsEvaluateViewController.h"

@interface LsMyLiveListViewController ()<UITableViewDelegate,UITableViewDataSource,myLiveTabDelegate,liveTableViewCellDelegate>
{
    float      startY;
    BOOL       isScroll;

}
@property (nonatomic,strong)  LsMyLiveModel            *model;
@property (nonatomic,strong)  UITableView              *todayLiveTabView;
@property (nonatomic,strong)  UITableView              *playBackTabView;
@property (nonatomic,strong)  UITableView              *notBeginTabView;
@property (nonatomic,strong)  UIScrollView             *scrView;
@property (nonatomic,strong)  LsMyLiveTabView          *headerTabView;

@end

@implementation LsMyLiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"我的直播";
    superView.backgroundColor =LSColor(243, 244, 245, 1);

    [self loadBaseUI];
    [self getData];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"top_background"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW, topImage.size.height)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    [superView bringSubviewToFront:self.navView];
    [superView addSubview:self.headerTabView];
    [superView addSubview:self.scrView];
    
    [self.scrView   addSubview:self.todayLiveTabView];
    [self.scrView   addSubview:self.notBeginTabView];
    [self.scrView   addSubview:self.playBackTabView];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"mycourse.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model      =[LsMyLiveModel yy_modelWithJSON:responseObject];
//        [self.scrView   addSubview:self.todayLiveTabView];
//        [self.scrView   addSubview:self.notBeginTabView];
//        [self.scrView   addSubview:self.playBackTabView];
        [self.todayLiveTabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag==20010) {
        return self.model.todayLive.livingList.count+self.model.todayLive.todayLiveList.count;
    }else if(tableView.tag==20020){
        return self.model.notBegin.count;
    }else{
        return self.model.playBack.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate =self;
    LsLiveModel *modelll =[[LsLiveModel alloc] init];
    if (tableView.tag==20010) {
        if (indexPath.row+1<=self.model.todayLive.livingList.count) {
            modelll =self.model.todayLive.livingList[indexPath.row];
            [cell reloadCell:modelll Type:@"3"];
        }else{
            if (self.model.todayLive.todayLiveList.count>0) {
                modelll =self.model.todayLive.todayLiveList[indexPath.row-self.model.todayLive.livingList.count];
                [cell reloadCell:modelll Type:@"4"];
            }
        }
    }else if(tableView.tag==20020){
        if (self.model.notBegin.count>0) {
            modelll  =self.model.notBegin[indexPath.row];
            [cell reloadCell:modelll Type:@"5"];
        }
    }else{
        if (self.model.playBack.count>0) {
            modelll  =self.model.playBack[indexPath.row];
            [cell reloadCell:modelll Type:@"6"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView.tag==20010) {
        
    }else if(tableView.tag==20020){
        
    }else{
        
    }
}

#pragma - mark -  LsLiveTableViewCell 代理
- (void)didClickIntoBtn:(NSString *)ID  isPackage:(BOOL)ispackage{
    if (ispackage) {
        LsLiveDetailViewController *vc =[[LsLiveDetailViewController alloc] init];
        vc.classId                     =ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [LsMethod alertMessage:@"直接进入直播间" WithTime:2];
    }
}
- (void)didClickEvaluateBtnIndex:(NSInteger)index{
    LsEvaluateViewController *vc =[[LsEvaluateViewController alloc] init];
    vc.classID                   =[NSString stringWithFormat:@"%ld",(long)index];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma - mark -  LsMyLiveTabView 代理
- (void)didClickMyLiveTabViewIndex:(NSInteger)index{
    LsLog(@"---------didClickMyLiveTabViewIndex---%d",index);
    if (index==0) {
        [self.todayLiveTabView reloadData];
    }else if (index==1){
        [self.notBeginTabView reloadData];
    }else{
        [self.playBackTabView reloadData];
    }
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float currentPostion = scrollView.contentOffset.y;
    BOOL  upDown = false;
    if (currentPostion - startY > 0 ||startY - currentPostion > 0) {
        startY = currentPostion;
        upDown=YES;
    }else{
        NSInteger index =scrollView.contentOffset.x/LSMainScreenW;
        if (isScroll&&!upDown) {
            [self.headerTabView switchMyLiveTab:index];
            if (index==0) {
                [self.todayLiveTabView reloadData];
            }else if (index==1){
                [self.notBeginTabView reloadData];
            }else{
                [self.playBackTabView reloadData];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScroll =YES;
    if (scrollView.contentOffset.y>0) {
        isScroll =NO;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    isScroll =NO;
}


#pragma - mark -  懒加载
-(UITableView *)playBackTabView{
    if (!_playBackTabView) {
        _playBackTabView =[[UITableView alloc] initWithFrame:CGRectMake(LSMainScreenW*2,0, LSMainScreenW,self.scrView.frame.size.height)];
        _playBackTabView.delegate         =self;
        _playBackTabView.dataSource       =self;
        _playBackTabView.tableFooterView  =[[UIView alloc] init];
        _playBackTabView.showsVerticalScrollIndicator   =NO;
        _playBackTabView.tag              =20030;
        _playBackTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _playBackTabView.backgroundColor  =[UIColor clearColor];
    }
    return _playBackTabView;
}

-(UITableView *)notBeginTabView{
    if (!_notBeginTabView) {
        _notBeginTabView =[[UITableView alloc] initWithFrame:CGRectMake(LSMainScreenW,0, LSMainScreenW,self.scrView.frame.size.height)];
        _notBeginTabView.delegate         =self;
        _notBeginTabView.dataSource       =self;
        _notBeginTabView.tableFooterView  =[[UIView alloc] init];
        _notBeginTabView.showsVerticalScrollIndicator   =NO;
        _notBeginTabView.tag              =20020;
        _notBeginTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _notBeginTabView.backgroundColor  =[UIColor clearColor];
    }
    return _notBeginTabView;
}

-(UITableView *)todayLiveTabView{
    if (!_todayLiveTabView) {
        _todayLiveTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW,self.scrView.frame.size.height)];
        _todayLiveTabView.delegate         =self;
        _todayLiveTabView.dataSource       =self;
        _todayLiveTabView.tableFooterView  =[[UIView alloc] init];
        _todayLiveTabView.showsVerticalScrollIndicator   =NO;
        _todayLiveTabView.tag              =20010;
        _todayLiveTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _todayLiveTabView.backgroundColor  =[UIColor clearColor];
    }
    return _todayLiveTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerTabView.frame)+10*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.headerTabView.frame))];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*3, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.backgroundColor                  =[UIColor clearColor];
        _scrView.bounces                          =NO;
        _scrView.delegate                         =self;
    }
    return _scrView;
}

-(LsMyLiveTabView *)headerTabView{
    if (!_headerTabView) {
        _headerTabView  =[[LsMyLiveTabView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.navView.frame), LSMainScreenW-20, 85)];
        _headerTabView.layer.cornerRadius =6;
        _headerTabView.backgroundColor    =[UIColor whiteColor];
        _headerTabView.delegate           =self;
    }
    return _headerTabView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
