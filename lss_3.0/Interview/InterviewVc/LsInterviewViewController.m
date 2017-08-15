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

static NSString *cellId = @"cellId";

@interface LsInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate>
{
    NSArray  *cellHeaderArray;
}
@property (nonatomic,strong)  NSArray                  *bannerArray;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UCCarouselView           *carouselView;
@property (nonatomic,strong)  LsInterView              *typeView;
@property (nonatomic,strong)  LsInterModel             *model;

@end

@implementation LsInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"面试";
    [self getData];
    [self getUserInfo];
    [self initData];
//    [self loadBaseUI];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSPOST:@"homepagejson.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model =[LsInterModel yy_modelWithJSON:responseObject];
        [self loadBaseUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

-(void)getUserInfo{
    
}

-(void)initData{
//    _bannerArray = @[LOADIMAGEWITHTYPE(@"banner1", @"jpg"),LOADIMAGEWITHTYPE(@"banner2", @"jpg"),
//                     LOADIMAGEWITHTYPE(@"banner3", @"jpg"),LOADIMAGEWITHTYPE(@"banner4", @"jpg"),
//                     LOADIMAGEWITHTYPE(@"banner5", @"jpg")];
    cellHeaderArray =@[@{@"leftTitle":@"最新直播",@"rightTitle":@"更多"},
                       @{@"leftTitle":@"最新练课",@"rightTitle":@"全部"}];
}

-(void)loadBaseUI{
    [self loadCarouselViewWithTimer];
    [superView addSubview:self.typeView];
    [superView addSubview:self.tabView];
}

// 使用定时器初始化
- (void)loadCarouselViewWithTimer {

    _carouselView  =[[UCCarouselView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 140*LSScale)
                                                dataArray:self.bannerArray
                                             timeInterval:2
                                       didSelectItemBlock:^(NSInteger didSelectItem){
          LsLog(@"--------------%d",didSelectItem);
    }];
    [superView addSubview:_carouselView];
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
        return 100*LSScale;
    }else{
        if (self.model.practiceModel.personNum>0) {
            if (indexPath==0) {
                return 30*LSScale;
            }else{
                return 168*LSScale;
            }
        }else{
            return 168*LSScale;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.model.liveArray.count;
    }else{
        return self.model.practiceModel.personNum>0?self.model.practiceModel.practiceLists.count+1:self.model.practiceModel.practiceLists.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (!cell) {
        if (indexPath.section==0) {
            cell = [[LsLiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:cellId];
        }else{
            cell = [[LsPracticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:cellId];
        }
    }
    if (indexPath.section==0) {
        
        cell = [[LsLiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [(LsLiveTableViewCell*)cell reloadCell:self.model.liveArray[indexPath.row]];
        
    }else{
        cell = [[LsPracticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    LsInterCellHeaderView *cellHeaderView =[[LsInterCellHeaderView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 45)];
    NSDictionary          *dict           =cellHeaderArray[section];
    NSString              *leftTitle      =[dict objectForKey:@"leftTitle"];
    NSString              *rightTitle     =[dict objectForKey:@"rightTitle"];
    [cellHeaderView setLeftTitle:leftTitle AndRightTitle:rightTitle];
    return cellHeaderView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 45;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)didClickHeaderViewIndex:(NSInteger)index{
    LsLog(@"+++++++++++++++++===%d",index);
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
        _typeView.dataArray =@[@{@"title":@"直播",@"imageName":@"zhibo"},
                               @{@"title":@"练课",@"imageName":@"lianke"},
                               @{@"title":@"资料",@"imageName":@"ziliao"},
                               @{@"title":@"公告",@"imageName":@"gonggao"}];
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

-(NSArray *)bannerArray{
    if (!_bannerArray) {
        NSMutableArray *dataArr =[NSMutableArray array];
        for (LsBannerModel *model in self.model.bannerArray) {
            [dataArr addObject:model.url];
        }
        _bannerArray =dataArr;
    }
    return _bannerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
