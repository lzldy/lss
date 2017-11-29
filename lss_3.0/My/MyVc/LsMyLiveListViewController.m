//
//  LsMyLiveListViewController.m
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyLiveListViewController.h"
#import "LsMyLiveListTableViewCell.h"
#import "LsMyLiveModel.h"
#import "LsMyLiveTabView.h"
#import "LsLiveDetailViewController.h"
#import "LsEvaluateViewController.h"
//#import "LsCustomPlayerViewController.h"
#import "LsPlayBackViewController.h"
#import "LsButton.h"

@interface LsMyLiveListViewController ()<UITableViewDelegate,UITableViewDataSource,myLiveTabDelegate,myLiveListTableViewCellDelegate>
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

@property (nonatomic,strong)  NSMutableArray           *enrollArray;
@property (nonatomic,strong)  NSMutableArray           *livingArray;
@property (nonatomic,strong)  NSMutableArray           *playbackArray;

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

-(void)processingData{
    
    for (LsMyLiveModel *model in self.model.dataList) {
        if ([model.livestatus isEqualToString:@"-1"]) {
            //正在报名
            [self.enrollArray addObject:model];
        }else if ([model.livestatus isEqualToString:@"0"]){
            //直播中
            [self.livingArray addObject:model];
        }else if ([model.livestatus isEqualToString:@"1"]){
            //可回放
            [self.playbackArray addObject:model];
        }
    }
    [self.todayLiveTabView reloadData];
}


-(void)getData{
    NSDictionary *dict  =@{@"paging":@"500"};
    [[LsAFNetWorkTool shareManger] LSPOST:@"qbcoursebuylist.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model      =[LsMyLiveModel yy_modelWithJSON:responseObject];
        [self processingData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag==20010) {
        return self.livingArray.count>0?self.livingArray.count:1;
    }else if(tableView.tag==20020){
        return self.enrollArray.count>0?self.enrollArray.count:1;
    }else{
        return self.playbackArray.count>0?self.playbackArray.count:1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsMyLiveListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsMyLiveListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate =self;
    LsMyLiveModel *modelll =[[LsMyLiveModel alloc] init];
    if (tableView.tag==20010) {
        if (self.livingArray.count>0) {
            modelll   =self.livingArray[indexPath.row];
            [cell reloadCell:modelll Type:@"1"];
        }else{
            [cell reloadCell:modelll Type:@"0"];
        }
    }else if(tableView.tag==20020){
        if (self.enrollArray.count>0) {
            modelll   =self.enrollArray[indexPath.row];
            [cell reloadCell:modelll Type:@"2"];
        }else{
            [cell reloadCell:modelll Type:@"0"];
        }
    }else{
        if (self.playbackArray.count>0) {
            modelll   =self.playbackArray[indexPath.row];
            [cell reloadCell:modelll Type:@"3"];
        }else{
            [cell reloadCell:modelll Type:@"0"];
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
- (void)didClickIntoBtn:(LsButton *)btn  isPackage:(BOOL)ispackage{
    LsLiveDetailViewController *vc =[[LsLiveDetailViewController alloc] init];
    vc.crcode                     =btn.videoID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickEvaluateBtnIndex:(LsButton *)btn{
    LsEvaluateViewController *vc =[[LsEvaluateViewController alloc] init];
    vc.classID                   =btn.videoID;
    vc.title_                    =btn.title;
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

-(NSMutableArray *)enrollArray{
    if (!_enrollArray) {
        _enrollArray =[NSMutableArray array];
    }
    return _enrollArray;
}

-(NSMutableArray *)livingArray{
    if (!_livingArray) {
        _livingArray =[NSMutableArray array];
    }
    return _livingArray;
}

-(NSMutableArray *)playbackArray{
    if (!_playbackArray) {
        _playbackArray =[NSMutableArray array];
    }
    return _playbackArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
