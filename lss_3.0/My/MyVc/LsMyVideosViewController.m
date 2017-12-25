//
//  LsMyVideosViewController.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyVideosViewController.h"
#import "LsNavTabView.h"
#import "LsDataModel.h"
#import "LsDataTableViewCell.h"

@interface LsMyVideosViewController ()<lsNavTabViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL       isScroll;
    float      startY;
    NSInteger  bkPage;
    NSInteger  ksbPage;
}

@property (nonatomic,strong)  LsNavTabView             *topTabView;
@property (nonatomic,strong)  UIScrollView             *scrView;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UITableView              *tabView1;

@property (nonatomic,strong)  LsDataModel              *model;
@property (nonatomic,strong)  LsDataModel              *model1;

@property (nonatomic,strong)  NSMutableArray           *bkDataArray;
@property (nonatomic,strong)  NSMutableArray           *ksbDataArray;

@end

@implementation LsMyVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"我的视频";
    superView.backgroundColor                  =LSColor(243, 244, 245, 1);
    [self.navView addSubview:self.topTabView];
    [superView addSubview:self.scrView];
    [self.scrView addSubview:self.tabView];
    [self.scrView addSubview:self.tabView1];
    
    [self getDataOfBK];
}

-(void)getDataOfBK{
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:bkPage] forKey:@"page"];
    [dict setValue:@"BK" forKey:@"ctag3"];
    
    [[LsAFNetWorkTool shareManger] LSPOST:@"listinfo.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model =[LsDataModel yy_modelWithJSON:responseObject];
        if (self.model.dataArray.count==0) {
            [LsMethod alertMessage:@"暂无数据" WithTime:1.5];
        }else{
            if (bkPage>0) {
                [self.bkDataArray addObjectsFromArray:self.model.dataArray];
            }else{
                self.bkDataArray =[NSMutableArray arrayWithArray:self.model.dataArray];
            }
            [self.tabView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)getDataOfKSB{
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:ksbPage] forKey:@"page"];
    [dict setValue:@"KSB" forKey:@"ctag3"];
    
    [[LsAFNetWorkTool shareManger] LSPOST:@"listinfo.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model1 =[LsDataModel yy_modelWithJSON:responseObject];
        if (self.model1.dataArray.count==0) {
            [LsMethod alertMessage:@"暂无数据" WithTime:1.5];
        }else{
            if (ksbPage>0) {
                [self.ksbDataArray addObjectsFromArray:self.model1.dataArray];
            }else{
                self.ksbDataArray =[NSMutableArray arrayWithArray:self.model1.dataArray];
            }
            [self.tabView1 reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==110) {
        return self.bkDataArray.count;
    }else{
        return self.ksbDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (tableView.tag==110) {
        [cell reloadCell:self.bkDataArray[indexPath.row]];
    }else{
        [cell reloadCell:self.ksbDataArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsDataDetailModel *model_;
    if (tableView.tag==110) {
        model_ =self.bkDataArray[indexPath.row];
    }else{
        model_=self.ksbDataArray[indexPath.row];
    }
//    LsDataDetailViewController *dataVc =[[LsDataDetailViewController alloc] init];
//    dataVc.title_                      =model_.title;
//    dataVc.ID                          =model_.id_;
//    [self.navigationController pushViewController:dataVc animated:YES];
}

#pragma - mark -    上下拉刷新
-(void)headerRefresh{
    isScroll=NO;
    bkPage  =0;
    [self getDataOfBK];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    isScroll=NO;
    
    bkPage ++;
    [self getDataOfBK];
    [self.tabView footerEndRefreshing];
}

-(void)headerRefresh1{
    isScroll =NO;
    ksbPage  =0;
    [self getDataOfKSB];
    [self.tabView1 headerEndRefreshing];
}

-(void)footerRefresh1{
    isScroll=NO;
    ksbPage ++;
    [self getDataOfKSB];
    [self.tabView1 footerEndRefreshing];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
        [self.tabView headerBeginRefreshing];
        [self headerRefresh];
    }else{
        [self.tabView1 headerBeginRefreshing];
        [self headerRefresh1];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    float currentPostion = scrollView.contentOffset.y;
    BOOL  upDown = false;
    if (currentPostion - startY > 0 ||startY - currentPostion > 0) {
        startY = currentPostion;
        upDown = YES;
    }else{
        float index =scrollView.contentOffset.x/LSMainScreenW;
        if (isScroll&&!upDown) {
            [self.topTabView tabIndex:index];
            //            if (index==1&&!_writtenModel) {
            //                [self.writtenTabView headerBeginRefreshing];
            //            }
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

-(LsNavTabView *)topTabView{
    if (!_topTabView) {
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-100, 20+7, 200, 30)];
        _topTabView.dataArray =@[@"已上传",@"未上传"];
        _topTabView.delegate=self;
    }
    return _topTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+10*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame)-10*LSScale)];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, self.scrView.frame.size.height)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.tag              =110;
        //增加上拉下拉刷新事件
        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(UITableView *)tabView1{
    if (!_tabView1) {
        _tabView1 =[[UITableView alloc] initWithFrame:CGRectMake(LSMainScreenW, 0, LSMainScreenW, self.scrView.frame.size.height)];
        _tabView1.delegate         =self;
        _tabView1.dataSource       =self;
        _tabView1.tableFooterView  =[[UIView alloc] init];
        _tabView1.showsVerticalScrollIndicator   =NO;
        _tabView1.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView1.tag              =210;
        
        //增加上拉下拉刷新事件
        [_tabView1 addHeaderWithTarget:self action:@selector(headerRefresh1)];
        [_tabView1 addFooterWithTarget:self action:@selector(footerRefresh1)];
    }
    return _tabView1;
}

-(LsDataModel *)model{
    if (!_model) {
        _model =[[LsDataModel alloc] init];
    }
    return _model;
}

-(LsDataModel *)model1{
    if (!_model1) {
        _model1 =[[LsDataModel alloc] init];
    }
    return _model1;
}

-(NSMutableArray *)bkDataArray{
    if (!_bkDataArray) {
        _bkDataArray =[NSMutableArray array];
    }
    return _bkDataArray;
}

-(NSMutableArray *)ksbDataArray{
    if (!_ksbDataArray) {
        _ksbDataArray =[NSMutableArray array];
    }
    return _ksbDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
