//
//  LsLiveViewController.m
//  lss
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveViewController.h"
#import "LsLiveTableViewCell.h"
#import "LsNavTabView.h"
#import "LsLiveDetailViewController.h"
#import "LsLiveModel.h"
#import "LsMyLiveListViewController.h"

@interface LsLiveViewController ()<lsNavTabViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  indexTabView;
    BOOL       isScroll;
    float      startY;
    UIView     *myLive;
    NSInteger  interviewPage;
    NSInteger  writtenPage;
}
@property (nonatomic,strong) LsNavTabView *topTabView;
@property (nonatomic,strong) UIScrollView *scrView;
@property (nonatomic,strong) UITableView  *interviewTabView;//面试
@property (nonatomic,strong) UITableView  *writtenTabView;//笔试
@property (nonatomic,strong) LsLiveModel  *interviewModel;
@property (nonatomic,strong) LsLiveModel  *writtenModel;

@property (nonatomic,strong) NSMutableArray *interviewDataArray;
@property (nonatomic,strong) NSMutableArray *writtenDataArray;

@end

@implementation LsLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"直播";
    [self.navView addSubview:self.topTabView];
    [self loadBaseUI];
    [self getInterviewData];
}

-(void)getInterviewData{
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:interviewPage] forKey:@"page"];
    
    [[LsAFNetWorkTool shareManger] LSPOST:@"listinterviewcourse.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        _interviewModel =[LsLiveModel yy_modelWithJSON:responseObject];
        if (interviewPage>0) {
            [self.interviewDataArray addObjectsFromArray:self.interviewModel.list];
        }else{
            self.interviewDataArray =[NSMutableArray arrayWithArray:self.interviewModel.list];
        }
        [self.interviewTabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)getWrittenData{
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:writtenPage] forKey:@"page"];
    
    [[LsAFNetWorkTool shareManger] LSPOST:@"listwrittencourse.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        _writtenModel =[LsLiveModel yy_modelWithJSON:responseObject];
        if (writtenPage>0) {
            [self.writtenDataArray addObjectsFromArray:self.writtenModel.list];
        }else{
            self.writtenDataArray =[NSMutableArray arrayWithArray:self.writtenModel.list];
        }
        [self.writtenTabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)loadBaseUI{
    myLive                  =[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW, 35*LSScale)];
    myLive.backgroundColor  =[UIColor whiteColor];
    [superView addSubview:myLive];
    
    UILabel *myL            =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale,0, LSMainScreenW-80*LSScale, 35*LSScale)];
    myL.text                =@"我报名的直播课";
    myL.textColor           =LSNavColor;
    myL.textAlignment       =NSTextAlignmentLeft;
    myL.font                =[UIFont systemFontOfSize:15.5*LSScale];
    [myLive addSubview:myL];
    
    UIImage *myImsge        =[UIImage imageNamed:@"hsh"];
    UIButton *myLiveBtn     =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-10*LSScale-35*LSScale, 0, 35*LSScale, 35*LSScale)];
    [myLiveBtn setImage:myImsge forState:0];
    [myLiveBtn addTarget:self action:@selector(clickMyLiveBtn) forControlEvents:UIControlEventTouchUpInside];
    [myLive addSubview:myLiveBtn];
    
    UIView *line            =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(myLive.frame)-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
    line.backgroundColor    =LSLineColor;
    [myLive addSubview:line];
    
    [superView addSubview:self.scrView];
    [self.scrView addSubview:self.interviewTabView];
    [self.scrView addSubview:self.writtenTabView];
}

-(void)clickMyLiveBtn{
    LsMyLiveListViewController *myLiveVc=[[LsMyLiveListViewController alloc] init];
    [self.navigationController pushViewController:myLiveVc animated:YES];
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag==10010) {
        return self.interviewDataArray.count>0?self.interviewDataArray.count:1;
    }else{
        return self.writtenDataArray.count>0?self.writtenDataArray.count:1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsLiveModel *modelll =[[LsLiveModel alloc] init];
    if (tableView.tag==10010){
        if (self.interviewDataArray.count>0) {
            modelll =self.interviewDataArray[indexPath.row];
            [cell reloadCell:modelll Type:@"2"];
        }else{
            [cell reloadCell:nil Type:@"0"];
        }
    }else{
        if (self.writtenDataArray.count>0) {
            modelll =self.writtenDataArray[indexPath.row];
            [cell reloadCell:modelll Type:@"2"];
        }else{
            [cell reloadCell:nil Type:@"0"];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsLiveModel *modelll =[[LsLiveModel alloc] init];
    if (tableView.tag==10010) {
        if (self.interviewDataArray.count>0) {
            modelll =self.interviewDataArray[indexPath.row];
        }else{
            modelll =nil;
        }
    }else{
        if (self.writtenDataArray.count>0) {
            modelll =self.writtenDataArray[indexPath.row];
        }else{
            modelll =nil;
        }
    }
    if (modelll) {
        LsLiveDetailViewController *detailVc =[[LsLiveDetailViewController alloc] init];
        detailVc.crcode                      =modelll.code;
        detailVc.personNum                   =modelll.personNum;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma - mark -    上下拉刷新
-(void)writtenTabViewHeaderRefresh{
    isScroll=NO;
    writtenPage =0;
    [self getWrittenData];
    [self.writtenTabView headerEndRefreshing];
}

-(void)writtenTabViewFooterRefresh{
    isScroll=NO;
    writtenPage ++;
    [self getWrittenData];
    [self.writtenTabView footerEndRefreshing];
}

-(void)interviewTabViewHeaderRefresh{
    isScroll=NO;
    interviewPage =0;
    [self getInterviewData];
    [self.interviewTabView headerEndRefreshing];
}

-(void)interviewTabViewFooterRefresh{
    isScroll=NO;
    interviewPage ++;
    [self getInterviewData];
    [self.interviewTabView footerEndRefreshing];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
        [self.interviewTabView headerBeginRefreshing];
        [self interviewTabViewHeaderRefresh];
    }else{
        [self.writtenTabView headerBeginRefreshing];
        [self writtenTabViewHeaderRefresh];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    float currentPostion = scrollView.contentOffset.y;
    BOOL  upDown = false;
    if (currentPostion - startY > 0 ||startY - currentPostion > 0) {
        startY = currentPostion;
        upDown=YES;
    }else{
        float index =scrollView.contentOffset.x/LSMainScreenW;
        if (isScroll&&!upDown) {
            [self.topTabView tabIndex:index];
            if (index==1&&!_writtenModel) {
                [self.writtenTabView headerBeginRefreshing];
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

#pragma - mark -    懒加载
-(LsNavTabView *)topTabView{
    if (!_topTabView) {
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-80, 20+7, 160, 30)];
        _topTabView.dataArray =@[@"面试",@"笔试"];
        _topTabView.delegate=self;
    }
    return _topTabView;
}

-(UITableView *)writtenTabView{
    if (!_writtenTabView) {
        _writtenTabView =[[UITableView alloc] initWithFrame:CGRectMake(LSMainScreenW,0, LSMainScreenW,self.scrView.frame.size.height)];
        _writtenTabView.delegate         =self;
        _writtenTabView.dataSource       =self;
        _writtenTabView.tableFooterView  =[[UIView alloc] init];
        _writtenTabView.showsVerticalScrollIndicator   =NO;
        _writtenTabView.tag              =10086;
        _writtenTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _writtenTabView.backgroundColor  =[UIColor clearColor];
        //增加上拉下拉刷新事件
        [_writtenTabView addHeaderWithTarget:self action:@selector(writtenTabViewHeaderRefresh)];
        [_writtenTabView addFooterWithTarget:self action:@selector(writtenTabViewFooterRefresh)];
    }
    return _writtenTabView;
}

-(UITableView *)interviewTabView{
    if (!_interviewTabView) {
        _interviewTabView =[[UITableView alloc] initWithFrame:CGRectMake(0,0, LSMainScreenW,self.scrView.frame.size.height)];
        _interviewTabView.delegate         =self;
        _interviewTabView.dataSource       =self;
        _interviewTabView.tableFooterView  =[[UIView alloc] init];
        _interviewTabView.showsVerticalScrollIndicator   =NO;
        _interviewTabView.tag              =10010;
        _interviewTabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _interviewTabView.backgroundColor  =[UIColor clearColor];
        //增加上拉下拉刷新事件
        [_interviewTabView addHeaderWithTarget:self action:@selector(interviewTabViewHeaderRefresh)];
        [_interviewTabView addFooterWithTarget:self action:@selector(interviewTabViewFooterRefresh)];
    }
    return _interviewTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myLive.frame),LSMainScreenW, LSMainScreenH-CGRectGetMaxY(myLive.frame))];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

-(NSMutableArray *)interviewDataArray{
    if (!_interviewDataArray) {
        _interviewDataArray =[NSMutableArray array];
    }
    return _interviewDataArray;
}

-(NSMutableArray *)writtenDataArray{
    if (!_writtenDataArray) {
        _writtenDataArray  =[NSMutableArray array];
    }
    return _writtenDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
