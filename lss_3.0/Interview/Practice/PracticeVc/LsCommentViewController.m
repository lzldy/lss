//
//  LsCommentViewController.m
//  lss
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCommentViewController.h"
#import "LsCommentTableViewCell.h"
#import "LsCommentView.h"

@interface LsCommentViewController ()<UITableViewDelegate,UITableViewDataSource,commentViewDelegate,commentTableViewCellDelegate>

@property (nonatomic,strong) UITableView *tabView;

@end

@implementation LsCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    self.navView.navTitle      =@"教师资格证备考视频";
    [self.navView.rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateSelected];
    [self.navView.rightButton addTarget:self action:@selector(didClickNavViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];

    [superView addSubview:self.tabView];
}

-(void)didClickNavViewRightBtn:(UIButton*)button{
    [LsMethod alertMessage:@"分享" WithTime:1.5];
}

- (void)replyComment:(UIButton *)button{
    LsCommentView *commentView     =[[LsCommentView alloc] init];
    commentView.delegate           =self;
    commentView.textPlaceholder    =@"回复李老师的点评";
    commentView.commitBtnText      =@"发送回复";
    [superView addSubview:commentView];
}

- (void)didClickCommitButton:(NSString*)text{
    [LsMethod alertMessage:text WithTime:1.5];
}

#pragma - mark -  tabview 代理
-(void)headerRefresh{
    [self.tabView reloadData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    [self.tabView reloadData];
    [self.tabView footerEndRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    //    return self.model.practiceDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    LsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate    =self;
    [cell reloadCellWithData:nil type:@"1"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    LsPracticeListModel *model            =self.model.practiceDataArray[indexPath.row];
    //    LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
    //    //    praVc.authorType                      =model.authorType ;
    //    praVc.authorType                      =@"学生";
    //    [self.navigationController pushViewController:praVc animated:YES];
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end