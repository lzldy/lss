//
//  LsLiveDetailViewController.m
//  lss
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailViewController.h"
#import "LsLiveDetailModel.h"
#import "LsLiveDetailHeaderView.h"
#import "LsLiveDetailTableViewCell.h"
#import "LsLiveDetailBottomView.h"
#import "LsEnrollSuccessViewController.h"

@interface LsLiveDetailViewController ()<liveDetailHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource,liveDetailBottomViewDelegate,liveDetailTableViewCellDelegate>

@property (nonatomic,strong) LsLiveDetailModel      *model;
@property (nonatomic,strong) LsLiveDetailHeaderView *headerView;
@property (nonatomic,strong) UITableView            *tabView;
@property (nonatomic,strong) LsLiveDetailBottomView *bottomView;
@property (nonatomic,strong) UIView                 *backgroundView;

@end

@implementation LsLiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   =LSColor(243, 244, 245, 1);
    self.navView.navTitle       =@"课程详情";
    [self loadBaseUI];
    [self getData];
}

-(void)loadBaseUI{
    UIImage     *topImage  =[UIImage imageNamed:@"top_background"];
    UIImageView *topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, topImage.size.height)];
    topImageV.image        =topImage;
    [superView addSubview:topImageV];
    [superView bringSubviewToFront:self.navView];
    
    _headerView =[[LsLiveDetailHeaderView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.navView.frame), LSMainScreenW-20, 90)];
    _headerView.delegate =self;
    [superView addSubview:_headerView];
    
    _bottomView =[[LsLiveDetailBottomView alloc] initWithFrame:CGRectMake(0, LSMainScreenH-50*LSScale, LSMainScreenW, 50*LSScale)];
    _bottomView.delegate =self;
}

-(void)initCourseIntroductionView{
    _backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_headerView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-50*LSScale-CGRectGetMaxY(_headerView.frame)-10*LSScale)];
    _backgroundView.backgroundColor =[UIColor whiteColor];
    _backgroundView.hidden=YES;
    
    UILabel  * label     =[[UILabel alloc]  initWithFrame:CGRectMake(15*LSScale, 0, LSMainScreenW-30*LSScale, 30*LSScale)];
    label.text           =@"课程介绍";
    label.textColor      =[UIColor darkGrayColor];
    label.textAlignment  =NSTextAlignmentLeft;
    label.font           =[UIFont systemFontOfSize:13.5*LSScale];
    [_backgroundView addSubview:label];
    
    UIView  *line        =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), LSMainScreenW, 0.8)];
    line.backgroundColor =LSLineColor;
    [_backgroundView addSubview:line];
    
    UIImageView  *imageview  =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), LSMainScreenW, LSMainScreenH-CGRectGetMaxY(line.frame)-50*LSScale)];
    [imageview sd_setImageWithURL:_model.courseIntroduction.introduceUrl placeholderImage:[UIImage imageNamed:@""]];
    [superView addSubview:_backgroundView];
}

-(void)getData{
    NSDictionary *dict =@{@"courseid":self.classId};
    [[LsAFNetWorkTool shareManger] LSPOST:@"getcourseinfo.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        _model  =[LsLiveDetailModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
        _headerView.model =_model;
        _bottomView.model=_model;
        if (_model.isPackage) {
            [self initCourseIntroductionView];
            [superView addSubview:self.tabView];
        }
        [superView addSubview:_bottomView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

- (void)didClickBtnIndex:(NSInteger)index{
    if (index==0) {
        self.tabView.hidden    =NO;
        _backgroundView.hidden =YES;
        [superView bringSubviewToFront:self.tabView];
        [self.tabView.layer addAnimation:[LsMethod opacityAnimationFormValue:0 ToValue:1] forKey:nil];
    }else{
        self.tabView.hidden    =YES;
        _backgroundView.hidden =NO;
        [superView bringSubviewToFront:_backgroundView];
        [_backgroundView.layer addAnimation:[LsMethod opacityAnimationFormValue:0 ToValue:1] forKey:nil];
    }
}

- (void)didEnrollSuccess:(LsLiveDetailModel*)detailModel{
    LsLog(@"---------------报名成功--------------");
    LsEnrollSuccessViewController *vc =[[LsEnrollSuccessViewController alloc] init];
    vc.model =detailModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  - mark -  tabview 代理
- (void)didClickPlayBtnWithID:(NSString*)videoid{
    [LsMethod alertMessage:[NSString stringWithFormat:@"videoid=%@",videoid] WithTime:2];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model.courseArrangement.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsLiveDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsLiveDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate=self;
    if (self.model.courseArrangement.count>0) {
        LsCourseArrangementModel *modelll =[[LsCourseArrangementModel alloc] init];
        modelll  =self.model.courseArrangement[indexPath.row];
        [cell reloadCell:modelll];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_headerView.frame)+10*LSScale, LSMainScreenW,LSMainScreenH-50*LSScale-CGRectGetMaxY(_headerView.frame)-10*LSScale)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.backgroundColor  =[UIColor clearColor];
    }
    return _tabView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end