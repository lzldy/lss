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

@interface LsInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate,interCellHeaderViewDelegate,practiceTableViewCellDelegate>
{
    NSArray  *cellHeaderArray;
}
@property (nonatomic,strong)  NSArray                  *bannerArray;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UCCarouselView           *carouselView;
@property (nonatomic,strong)  LsInterView              *typeView;
@property (nonatomic,strong)  LsInterModel             *model;
@property (nonatomic,strong)  LsBannerModel            *banModel;

@end

@implementation LsInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"";
    [self getBannerData];
    [self getUserInfo];
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

}

-(void)initData{
    cellHeaderArray =@[@{@"leftTitle":@"最新直播",@"rightTitle":@"更多"},
                       @{@"leftTitle":@"最新练课",@"rightTitle":@"全部"}];
}

-(void)loadBaseUI{
    [self loadCarouselViewWithTimer];
    [superView addSubview:self.typeView];
    [superView addSubview:self.tabView];
    UIImage   *image         =[UIImage imageNamed:@"ct_icon"];
    UIButton  *suspensionBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-10-image.size.width, LSMainScreenH-49-10-image.size.height, image.size.width, image.size.height)];
    [suspensionBtn setImage:image forState:UIControlStateNormal];
    [suspensionBtn addTarget:self action:@selector(clickSuspensionBtn) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:suspensionBtn];
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
                                             timeInterval:2
                                       didSelectItemBlock:^(NSInteger didSelectItem){
           [weakSelf bannerDetailVc:self.banModel.bannerArray[didSelectItem].clickurl];
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
-(void)headerRefresh{
    [self.tabView reloadData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    [self.tabView reloadData];
    [self.tabView footerEndRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 125*LSScale;
    }else{
        if (self.model.practiceModel.personNum>0) {
            if (indexPath.row==0) {
                return 35;
            }else{
                return 210*LSScale;
            }
        }else{
            return 210*LSScale;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.model.liveArray.count>0?self.model.liveArray.count:1;
    }else{
        return self.model.practiceModel.personNum>0?self.model.practiceModel.practiceLists.count+1:self.model.practiceModel.practiceLists.count;
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
        if (self.model.practiceModel.personNum>0) {
            if (indexPath.row==0) {
                [cell reloadCell:self.model.practiceModel Type:@"0"] ;
                cell.delegate=self;
            }else{
                [cell reloadCell:self.model.practiceModel.practiceLists[indexPath.row-1] Type:@"1"] ;
            }
        }
//        }else{
//            [cell reloadCell:self.model.practiceModel.practiceLists[indexPath.row] Type:@"1"] ;
//        }
        return cell;
    }
}

- (void)didClickRightButton{
    [self pushPracticeVc:0];
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
        if (indexPath.row==0&&self.model.practiceModel.personNum>0) {
            [self pushPracticeVc:0];
        }else{
            LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
//            praVc.authorType                      =self.model.practiceModel.practiceLists[indexPath.row-1].ctag2;
            praVc.code_                       =self.model.practiceModel.practiceLists[indexPath.row-1].code;
            [self.navigationController pushViewController:praVc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    LsInterCellHeaderView *cellHeaderView =[[LsInterCellHeaderView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 50)];
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
            [self pushPracticeVc:0];
            break;
        case 2:
            [self pushDataVc:0];
            break;
        case 3:
            [self pushNoticeVc:0];
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

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.typeView.frame)-49)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =LSColor(243, 244, 245, 1);
        //增加上拉下拉刷新事件
        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(LsInterView *)typeView{
    if (!_typeView) {
        _typeView =[[LsInterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carouselView.frame), LSMainScreenW, 80)];
    _typeView.dataArray =@[@{@"title":@"直播",@"imageName":@"zhibo",@"color":LSColor(255,61,49,1)},
                           @{@"title":@"练课",@"imageName":@"lianke",@"color":LSColor(255,72,130,1)},
                           @{@"title":@"资料",@"imageName":@"ziliao",@"color":LSColor(133,106,255,1)},
                           @{@"title":@"公告",@"imageName":@"gonggao",@"color":LSColor(87,160,255,1)}];
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
        for (LsBannerModel *model in self.banModel.bannerArray) {
            [dataArr addObject:model.picurl];
        }
        _bannerArray =dataArr;
    }
    return _bannerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
