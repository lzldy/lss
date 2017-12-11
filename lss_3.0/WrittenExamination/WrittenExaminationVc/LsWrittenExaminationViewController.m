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

@interface LsWrittenExaminationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView  *tabView;

@end

@implementation LsWrittenExaminationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.navTitle     =@"针对性刷题";
    superView.backgroundColor =LSColor(243, 244, 245, 1);
    [self loadBaseUI];
    [self getData];
}

-(void)loadBaseUI{
    [superView addSubview:self.tabView];
}

-(void)getData{
//    catgid：项目ID，建议必选
//    scatgid：学科ID，建议必选
//    prvn：指定省，名称中没有省，比如湖南/北京，可选
//    city：指定城市，名称中没有市，比如长沙，可选
//    needstatis：是否需要返回个人做题统计，在做题主页，需要设置此参数为Y，可选参数.
    
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:[LSUser_Default objectForKey:@"catgid"]  forKey:@"catgid"];
    [dict setObject:[LSUser_Default objectForKey:@"scatgid"] forKey:@"scatgid"];
    [dict setObject:@"湖南" forKey:@"prvn"];
    [dict setObject:@"长沙" forKey:@"city"];
//    [dict setObject:@"Y" forKey:@"needstatis"];

    [[LsAFNetWorkTool shareManger] LSGET:@"qbpaperlib.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
//    [[LsAFNetWorkTool shareManger] LSPOST:@"qbpaperlib.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
//
//    }];
}

#pragma  - mark -  tabview 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"upCellID";
    LsWrittenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsWrittenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView  *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 30*LSScale)];
    view.backgroundColor =[UIColor whiteColor];
    UILabel *titleL     =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 0, 200, 30*LSScale)];
    titleL.font         =[UIFont systemFontOfSize:13.5*LSScale];
    titleL.textAlignment=NSTextAlignmentLeft;
    [view addSubview:titleL];
    
    UIView  *line =[[UIView alloc] initWithFrame:CGRectMake(0, 30*LSScale-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
    line.backgroundColor =LSLineColor;
    [view addSubview:line];
    
    titleL.text         =[NSString stringWithFormat:@"section==%ld",(long)section];

    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 30*LSScale)];
    UILabel *titleL     =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 0, 200, 30*LSScale)];
    titleL.font         =[UIFont systemFontOfSize:12*LSScale];
    titleL.textAlignment=NSTextAlignmentLeft;
    titleL.textColor    =LSNavColor;
    view.backgroundColor =[UIColor whiteColor];
    [view addSubview:titleL];

    if (tableView.tag==100) {
        titleL.text         =@"查看所有试卷";
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30*LSScale;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 30*LSScale;
//}

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
