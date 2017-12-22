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
#import "LsPracticeDetailModel.h"

@interface LsCommentViewController ()<UITableViewDelegate,UITableViewDataSource,commentViewDelegate,commentTableViewCellDelegate>

@property (nonatomic,strong) UITableView               *tabView;
@property (nonatomic,strong) LsPracticeCommentModel    *commentModel;
@property (nonatomic,strong) NSString                  *commentid;
@property (nonatomic,strong) NSMutableArray            *dataArray;
@end

@implementation LsCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    self.navView.navTitle      =@"教师资格证备考视频";
//    [self.navView.rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
//    [self.navView.rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateSelected];
//    [self.navView.rightButton addTarget:self action:@selector(didClickNavViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];

    [superView addSubview:self.tabView];
    
    [self getCommentData];
}

-(void)getCommentData{
    NSDictionary *dict =@{@"commenttype":@"TT",@"code":self.code,@"commentchild":@"Y"};
    [[LsAFNetWorkTool shareManger] LSPOST:@"listtablecomment.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.commentModel  =[LsPracticeCommentModel yy_modelWithJSON:responseObject];
        
        self.dataArray =[NSMutableArray array];
        for (LsPracticeCommentModel *model in self.commentModel.dataList) {
            NSMutableArray *arr =[NSMutableArray array];
            [arr addObject:model];
            if (model.replys.count>0) {
                for (LsPracticeCommentModel *model1 in model.replys) {
                    model1.toUserName  =model.fromUserName;
                    [arr addObject:model1];
                }
            }
            [self.dataArray addObject:arr];
        }
        [_tabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)didClickNavViewRightBtn:(UIButton*)button{
    [LsMethod alertMessage:@"分享" WithTime:1.5];
}

- (void)replyComment:(LsButton *)button{
    self.commentid                 = button.ID;
    LsCommentView *commentView     =[[LsCommentView alloc] init];
    commentView.delegate           =self;
    commentView.textPlaceholder    =@"回复李老师的点评";
    commentView.commitBtnText      =@"发送回复";
    [superView addSubview:commentView];
}

- (void)didClickCommitButton:(NSString*)text{
    [self commentVideoWithText:text];
}

-(void)commentVideoWithText:(NSString *)text{
    NSDictionary *dict =@{@"code":self.code,
                          @"comment":text,
                          @"commentid":self.commentid,
                          @"commenttype":@"TS"};
    [[LsAFNetWorkTool shareManger] LSPOST:@"commentvideotable.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [LsMethod alertMessage:@"评论成功" WithTime:1.5];
        [self getCommentData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
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
    return cell.frame.size.height>70*LSScale?cell.frame.size.height:70*LSScale;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array  =self.dataArray[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10*LSScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    LsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate    =self;
    LsPracticeCommentModel *model  =self.dataArray[indexPath.section][indexPath.row];
    if ([model.fromUserType isEqualToString:@"U"]) {
        [cell reloadCellWithData:model type:@"U"];
    }else{
        [cell reloadCellWithData:model type:@"T"];
    }
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
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-CGRectGetMaxY(self.navView.frame)-10*LSScale)];
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

-(LsPracticeCommentModel *)commentModel{
    if (!_commentModel) {
        _commentModel =[[LsPracticeCommentModel alloc] init];
    }
    return _commentModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
