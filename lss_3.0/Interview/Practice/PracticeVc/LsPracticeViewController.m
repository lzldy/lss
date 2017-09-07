//
//  LsPracticeViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPracticeViewController.h"
#import "LsChooseView.h"
#import "LsPracticeTableViewCell.h"
#import "LsPractiveDetailViewController.h"
#import "LsPracticeModel.h"

@interface LsPracticeViewController ()<chooseViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)  LsChooseView             *chooseView;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  LsPracticeModel          *model;

@end

@implementation LsPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"练课";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);

    [self.navView.rightButton setImage:[UIImage imageNamed:@"xl"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"sl"] forState:UIControlStateSelected];
    [self.navView.rightButton addTarget:self action:@selector(didClickNavViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];

    [superView addSubview:self.tabView];
    [superView addSubview:self.chooseView];
}

-(void)didClickNavViewRightBtn:(UIButton *)btn{
    if (btn.selected) {
        btn.selected=NO;
        self.chooseView.hidden=YES;
    }else{
        btn.selected=YES;
        self.chooseView.hidden=NO;
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
//    return self.model.practiceDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *sectionIDD = @"section1";
    LsPracticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionIDD];
    if (!cell) {
        cell = [[LsPracticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionIDD];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsPracticeListModel *model =self.model.practiceDataArray[indexPath.row];
    [cell reloadCell:model Type:@"2"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LsPracticeListModel *model            =self.model.practiceDataArray[indexPath.row];
    LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
//    praVc.authorType                      =model.authorType ;
    praVc.authorType                      =@"老师";
    [self.navigationController pushViewController:praVc animated:YES];
}


- (void)chooseBtn:(LsButton*)button{
    [LsMethod alertMessage:button.videoID WithTime:1.5];
    [self performSelector:@selector(hiddenChooseView) withObject:nil afterDelay:0.25];
}

-(LsChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView           =[[LsChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 70*LSScale)];
        _chooseView.dataArray =@[@{@"title":@"全部",@"ID":@"10"},
                                 @{@"title":@"说课",@"ID":@"11"},
                                 @{@"title":@"试讲",@"ID":@"12"},
                                 @{@"title":@"结构化",@"ID":@"13"},
                                 @{@"title":@"答辩",@"ID":@"14"}];
        _chooseView.hidden    =YES;
        _chooseView.delegate  =self;
    }
    return _chooseView;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame)-10*LSScale)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
        //增加上拉下拉刷新事件
        [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    }
    return _tabView;
}

-(LsPracticeModel *)model{
    if (!_model) {
        _model =[[LsPracticeModel alloc] init];
    }
    return _model;
}

-(void)hiddenChooseView{
    self.chooseView.hidden              =YES;
    self.navView.rightButton.selected   =NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hiddenChooseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
