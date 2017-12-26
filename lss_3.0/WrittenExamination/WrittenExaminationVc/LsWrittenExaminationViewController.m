//
//  LsProFormaViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWrittenExaminationViewController.h"
#import "LsNavTabView.h"
#import "LsWrittenHeaderView.h"
#import "LsWrittenTableViewCell.h"
#import "LsLiveTableViewCell.h"
#import "LsQuestionsModel.h"
#import "LsDataDetailViewController.h"
#import "LsPlaceView.h"
#import "LsPlaceModel.h"

@interface LsWrittenExaminationViewController ()<UITableViewDelegate,UITableViewDataSource,placeViewDelegate>
{
    NSString  *cityName;
}
@property (nonatomic,strong) UITableView      *tabView;
@property (nonatomic,strong) LsQuestionsModel *model;
@property (nonatomic,strong) LsPlaceView      *placeView;
@property (nonatomic,strong) LsPlaceModel     *placeModel;

@end

@implementation LsWrittenExaminationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.navTitle     =@"针对性刷题";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
    [self getPlace];
    [self getData];
}

-(void)loadBaseUI{
    self.navView.rightButton.frame  =CGRectMake(LSMainScreenW -80*LSScale, 20, 75*LSScale, 44);
    [self.navView.rightButton setTitle:[LsSingleton sharedInstance].user.branchName forState:0];
    [self.navView.rightButton addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:self.tabView];
    [superView addSubview:self.placeView];
}

-(void)clickRightBtn:(UIButton*)btn{
    btn.selected =!btn.selected;
    if (btn.selected) {
        self.placeView.hidden  = NO ;
    }else{
        self.placeView.hidden  = YES;
    }
}

- (void)didClickBtnIndex:(NSInteger)index{
    
    LsPlaceModel *modelll             =self.placeModel.dataArray[index];
    self.placeView.hidden             =YES;
    self.navView.rightButton.selected =NO;
    cityName                          =modelll.name;
    [self.navView.rightButton setTitle:modelll.name forState:0];

    [self getData];
}

-(void)getPlace{
    NSString     *regionid =[LsSingleton sharedInstance].user.branchPrvnId;
    if ([LsMethod haveValue:regionid]) {
        NSDictionary *dict     =@{@"regionid":regionid};
        [[LsAFNetWorkTool shareManger] LSPOST:@"listregion.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            self.placeModel            =[LsPlaceModel yy_modelWithJSON:responseObject];
            self.placeView.dataArray   =self.placeModel.dataArray;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        }];
    }else{
        [LsMethod alertMessage:@"未知省份" WithTime:1.5];
    }
}

-(void)getData{
//    catgid：项目ID，建议必选
//    scatgid：学科ID，建议必选
//    prvn：指定省，名称中没有省，比如湖南/北京，可选
//    city：指定城市，名称中没有市，比如长沙，可选
//    needstatis：是否需要返回个人做题统计，在做题主页，需要设置此参数为Y，可选参数.
    
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    if ([LsMethod haveValue:[LSUser_Default objectForKey:@"catgid"]]) {
        [dict setObject:[LSUser_Default objectForKey:@"catgid"]  forKey:@"catgid"];
    }
    if ([LsMethod haveValue:[LSUser_Default objectForKey:@"scatgid"]]) {
        [dict setObject:[LSUser_Default objectForKey:@"scatgid"] forKey:@"scatgid"];
    }
    if ([LsMethod haveValue:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"分校"]]) {
        [dict setObject:[[LSUser_Default objectForKey:@"配置"] objectForKey:@"分校"] forKey:@"prvn"];
    }
    
    [dict setObject:@"activity" forKey:@"mode"];
    if ([LsMethod haveValue:cityName]) {
        [dict setObject:cityName forKey:@"city"];
    }
//    [dict setObject:@"Y" forKey:@"needstatis"];

    [[LsAFNetWorkTool shareManger] LSPOST:@"qbpaperlib.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model  =[LsQuestionsModel yy_modelWithJSON:responseObject];
        [self.tabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {

    }];
}

#pragma  - mark -  tabview 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LsQuestionsModel *model =self.model.dataArray[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"upCellID";
    LsWrittenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsWrittenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    LsQuestionsModel        *model        =self.model.dataArray[indexPath.section];
    LsQuestionsDetailModel  *detailModel  =model.list[indexPath.row];
    
    [cell reloadCellWithData:detailModel];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsQuestionsModel *model        =self.model.dataArray[indexPath.section];
    LsQuestionsDetailModel *model1 =model.list[indexPath.row];
    LsDataDetailViewController *vc =[[LsDataDetailViewController alloc] init];
    vc.doExeUrl                    =model1.doExeUrl;
    vc.isDoExe                     =YES;
//    vc.code                        =model1.code;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40*LSScale;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView  *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 40*LSScale)];
    view.backgroundColor =LSColor(243, 244, 245, 1);
   
    UILabel *titleL     =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 0, 200, 40*LSScale)];
    titleL.font         =[UIFont systemFontOfSize:14.5*LSScale];
    titleL.textAlignment=NSTextAlignmentCenter;
    [view addSubview:titleL];
    
    UIView  *line =[[UIView alloc] initWithFrame:CGRectMake(0, 40*LSScale-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
    line.backgroundColor =LSLineColor;
    [view addSubview:line];
    
    LsQuestionsModel  *mdeolll  =self.model.dataArray[section];
    titleL.text         =[NSString stringWithFormat:@"%@",mdeolll.scatgName];
    CGSize  size        =[LsMethod sizeWithString:titleL.text font:titleL.font];
    titleL.frame        =CGRectMake(titleL.frame.origin.x, titleL.frame.origin.y, size.width, 40*LSScale);
    
    
    UILabel *detailL     =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleL.frame)+10*LSScale, 0, 120*LSScale, 40*LSScale)];
    detailL.font         =[UIFont systemFontOfSize:12*LSScale];
    detailL.textAlignment=NSTextAlignmentLeft;
    detailL.textColor    =LSColor(153, 153, 153, 1);
    [view addSubview:detailL];
    detailL.text         =[NSString stringWithFormat:@"共%@套试卷",mdeolll.total];

    return view;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
    }
    return _tabView;
}

-(LsQuestionsModel *)model{
    if (!_model) {
        _model  =[[LsQuestionsModel alloc] init];
    }
    return _model;
}

-(LsPlaceView *)placeView{
    if (!_placeView) {
        _placeView  =[[LsPlaceView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 10*LSScale)];
        _placeView.hidden    =YES;
        _placeView.delegate  =self;
    }
    return _placeView;
}

-(LsPlaceModel *)placeModel{
    if (!_placeModel) {
        _placeModel   =[[LsPlaceModel alloc] init];
    }
    return _placeModel;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
