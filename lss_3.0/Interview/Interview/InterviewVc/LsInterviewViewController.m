//
//  LsLiveBroadcastViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsInterviewViewController.h"
#import "UCCarouselView.h"
#import "LsLiveTableViewCell.h"
#import "LsPracticeTableViewCell.h"
#import "LsInterView.h"
#import "LsInterCellHeaderView.h"
#import "LsInterModel.h"
#import "LsPracticeViewController.h"
#import "LsLiveViewController.h"
#import "LsDataViewController.h"
#import "LsNoticeViewController.h"
#import "LsPumpingTestViewController.h"
#import "LsLiveDetailViewController.h"
#import "LsPractiveDetailViewController.h"
#import "LsDataDetailViewController.h"
#import "LsWrittenExaminationViewController.h"

@interface LsInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate,interCellHeaderViewDelegate>
{
    NSArray      *cellHeaderArray;
//    NSInteger    page;
}
@property (nonatomic,strong)  NSArray                  *bannerArray;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UCCarouselView           *carouselView;
@property (nonatomic,strong)  LsInterView              *typeView;
@property (nonatomic,strong)  LsInterModel             *model;
@property (nonatomic,strong)  LsBannerModel            *banModel;

@end

@implementation LsInterviewViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self  getUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"备考";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    [self getBannerData];
    [self initData];
}

-(void)getBannerData{
    NSDictionary *dict =@{@"page":@"HOME"};
    [[LsAFNetWorkTool shareManger] LSPOST:@"homebannerjson.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.banModel =[LsBannerModel yy_modelWithJSON:responseObject];
        [self loadBaseUI];
        [self getData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"homepagejson.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model =[LsInterModel yy_modelWithJSON:responseObject];
        [self.tabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

-(void)getUserInfo{
    [[LsAFNetWorkTool shareManger]  LSPOST:@"getusersetting.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [[LsSingleton sharedInstance]  yy_modelSetWithJSON:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)initData{
    cellHeaderArray =@[@{@"leftTitle":@"最新直播",@"rightTitle":@"更多"},
                       @{@"leftTitle":@"最新练课",@"rightTitle":@"更多"}];
}

-(void)loadBaseUI{
    [self loadCarouselViewWithTimer];
    [superView addSubview:self.typeView];
    [superView addSubview:self.tabView];
}

-(void)clickSuspensionBtn{
    LsPumpingTestViewController *testVc =[[LsPumpingTestViewController alloc] init];
    [self.navigationController pushViewController:testVc animated:YES];
}

// 使用定时器初始化
- (void)loadCarouselViewWithTimer {
    WS(weakSelf)
    _carouselView  =[[UCCarouselView alloc] initWithFrame:CGRectMake(0, 20, LSMainScreenW, 140*LSScale)
                                                dataArray:self.bannerArray
                                             timeInterval:3
                                       didSelectItemBlock:^(NSInteger didSelectItem){
       if (didSelectItem>=0&&self.banModel.bannerArray.count>0) {
           [weakSelf bannerDetailVc:self.banModel.bannerArray[didSelectItem].clickurl];
       }
    }];
    [superView addSubview:_carouselView];
}

-(void)bannerDetailVc:(NSURL*)url{
    LsDataDetailViewController *vc =[[LsDataDetailViewController alloc] init];
    vc.bannerUrl                   =url;
    vc.isBanner                    =YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma - mark -   UITableView 代理
//-(void)headerRefresh{
//    [self.tabView reloadData];
//    [self.tabView headerEndRefreshing];
//}
//
//-(void)footerRefresh{
//    [self.tabView reloadData];
//    [self.tabView footerEndRefreshing];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0?110*LSScale:265*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.model.liveArray.count>0?self.model.liveArray.count:1;
    }else{
        return self.model.practiceModel.practiceLists.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        static NSString *sectionID = @"section0";
        LsLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionID];
        if (!cell) {
            cell = [[LsLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.model.liveArray.count>0) {
            [cell reloadCell:self.model.liveArray[indexPath.row] Type:@"1"] ;
        }else{
            [cell reloadCell:nil Type:@"0"] ;
        }
        return cell;
    }else{
        static NSString *sectionIDD = @"section1";
        LsPracticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionIDD];
        if (!cell) {
            cell = [[LsPracticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionIDD];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.model.practiceModel.practiceLists>0) {
            [cell reloadCell:self.model.practiceModel.practiceLists[indexPath.row] Type:@"1"] ;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (self.model.liveArray.count>0) {
            LsLiveDetailViewController *detailVc =[[LsLiveDetailViewController alloc] init];
            detailVc.crcode                      =self.model.liveArray[indexPath.row].code;
            detailVc.personNum                   =self.model.liveArray[indexPath.row].personNum;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
    }else{
        LsPracticeListModel  *model =self.model.practiceModel.practiceLists[indexPath.row];
        if (![LsMethod haveValue:model.authorType]) {
            model.authorType =@"神秘人";
        }
            LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
            praVc.code_                           =model.code;
            praVc.authorType                      =model.authorType;
//            praVc.videoID                         =model.videoId;
//            praVc.didZan                          =model.myzan;
            [self.navigationController pushViewController:praVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10*LSScale;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    LsInterCellHeaderView *cellHeaderView =[[LsInterCellHeaderView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 40)];
    NSDictionary          *dict           =cellHeaderArray[section];
    cellHeaderView.delegate               =self;
    NSString              *leftTitle      =[dict objectForKey:@"leftTitle"];
    NSString              *rightTitle     =[dict objectForKey:@"rightTitle"];
    [cellHeaderView setLeftTitle:leftTitle AndRightTitle:rightTitle Index:section] ;
    return cellHeaderView;
}

- (void)didClickHeaderViewRightBtnIndex:(NSInteger)index{
    if (index==0) {
        [self pushLiveVc:0];
    }else{
        [self pushPracticeVc:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)didClickHeaderViewIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [self pushLiveVc:0];
            break;
        case 1:
            [self clickSuspensionBtn];
            break;
        case 2:
            [self pushPracticeVc:0];
            break;
        case 3:
            [self pushBrushQuestion];
            break;
        default:
            break;
    }
}

#pragma - mrak -   跳转各个VC
-(void)pushLiveVc:(NSInteger)id_{
    LsLiveViewController *vc =[[LsLiveViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushPracticeVc:(NSInteger)id_{
    LsPracticeViewController *vc =[[LsPracticeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushDataVc:(NSInteger)id_{
    LsDataViewController *vc =[[LsDataViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushNoticeVc:(NSInteger)id_{
    LsNoticeViewController *vc =[[LsNoticeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushBrushQuestion{
    LsWrittenExaminationViewController *vc =[[LsWrittenExaminationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.typeView.frame)-49)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =LSColor(243, 244, 245, 1);
        //增加上拉下拉刷新事件
//        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
//        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(LsInterView *)typeView{
    if (!_typeView) {
        _typeView =[[LsInterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carouselView.frame), LSMainScreenW, 95)];
    _typeView.dataArray =@[@{@"title":@"直播课堂",@"imageName":@"xin_icon",@"color":LSColor(127,127,127,1)},
                           @{@"title":@"面试抽题",@"imageName":@"nian_icon",@"color":LSColor(127,127,127,1)},
                           @{@"title":@"示范视频",@"imageName":@"kuai_icon",@"color":LSColor(127,127,127,1)},
                           @{@"title":@"笔试刷题",@"imageName":@"le_icon",@"color":LSColor(127,127,127,1)}];
        _typeView.delegate=self;
    }
    return _typeView;
}

-(LsInterModel *)model{
    if (!_model) {
        _model =[[LsInterModel alloc] init];
    }
    return _model;
}

-(LsBannerModel *)banModel{
    if (!_banModel) {
        _banModel  =[[LsBannerModel alloc] init];
    }
    return _banModel;
}

-(NSArray *)bannerArray{
    if (!_bannerArray) {
        NSMutableArray *dataArr =[NSMutableArray array];
        if (self.banModel.bannerArray.count>0) {
            for (LsBannerModel *model in self.banModel.bannerArray) {
                [dataArr addObject:model.picurl];
            }
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"banner.jpg" ofType:nil];
            [dataArr addObject:[NSURL fileURLWithPath:path]];
        }
        _bannerArray =dataArr;
    }
    return _bannerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
