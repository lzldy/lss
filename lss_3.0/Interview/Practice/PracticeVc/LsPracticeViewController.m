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
{
    NSInteger     page;
    NSString     *type;
}
@property (nonatomic,strong)  LsChooseView             *chooseView;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  LsPracticeModel          *model;
@property (nonatomic,strong)  NSMutableArray           *dataArray;

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
    
    [self getData];
}

-(void)getData{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if ([LsMethod haveValue:type]) {
        [dict setObject:type forKey:@"ctag1"];
    }
    [dict setObject:@"STUD" forKey:@"ctag2"];//仅推荐给老师参数TEACH
    [dict setObject:@"LK" forKey:@"ctag3"];
    [dict setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [[LsAFNetWorkTool shareManger] LSPOST:@"listvideotables.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model  =[LsPracticeModel yy_modelWithJSON:responseObject];
        if (page>0){
            [self.dataArray addObjectsFromArray:self.model.practiceDataArray];
        }else{
            self.dataArray =[NSMutableArray arrayWithArray:self.model.practiceDataArray];
        }
        [self.tabView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
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
    page =0;
    [self getData];
    [self.tabView headerEndRefreshing];
}

-(void)footerRefresh{
    page ++;
    [self getData];
    [self.tabView footerEndRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 280*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *sectionIDD = @"section1";
    LsPracticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionIDD];
    if (!cell) {
        cell = [[LsPracticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionIDD];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LsPracticeListModel *model =self.dataArray[indexPath.row];
    [cell reloadCell:model Type:@"2"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsPracticeListModel *modelll            =self.model.practiceDataArray[indexPath.row];
    if ([LsMethod haveValue:modelll.ctag2]) {
        if ([modelll.ctag2 isEqualToString:@"STUD"]) {
            modelll.ctag2 =@"学生";
        }else if([modelll.ctag2 isEqualToString:@"TEACH"]){
            modelll.ctag2 =@"名师";
        }
    }else{
        modelll.ctag2 =@"神秘人";
    }
    LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
    praVc.authorType                      =modelll.ctag2;
    praVc.code_                           =modelll.code;
//    praVc.videoID                         =modelll.videoId;
//    praVc.didZan                          =modelll.myzan;

    [self.navigationController pushViewController:praVc animated:YES];
}


- (void)chooseBtn:(LsButton*)button{
    page   =0;
    type   =button.videoID;
    [self  getData];
    [self performSelector:@selector(hiddenChooseView) withObject:nil afterDelay:0.25];
}

-(LsChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView           =[[LsChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 70*LSScale)];
        _chooseView.dataArray =@[@{@"title":@"全部",@"ID":@""},
                                 @{@"title":@"说课",@"ID":@"SK"},
                                 @{@"title":@"试讲",@"ID":@"SJ"},
                                 @{@"title":@"结构化",@"ID":@"JGH"},
                                 @{@"title":@"答辩",@"ID":@"DB"}];
        _chooseView.hidden    =YES;
        _chooseView.delegate  =self;
    }
    return _chooseView;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
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

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
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
