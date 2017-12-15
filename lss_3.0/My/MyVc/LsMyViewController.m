//
//  ViewController.m
//  lss_3.0
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyViewController.h"
#import "LsMyHeaderView.h"
#import "LsMyTableViewCell.h"
#import "LsFeedBackViewController.h"

@interface LsMyViewController ()<myHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    LsButton   * uploadBtn;
}
@property (nonatomic,strong) LsMyHeaderView *headerView;
@property (nonatomic,strong) UITableView    *tabView;
@property (nonatomic,strong) NSArray        *dataArray;

@end

@implementation LsMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle      =@"我的";
    superView.backgroundColor  =LSColor(243, 244, 245, 1);

    [self getData];
    [self loadBaseUI];
}

-(void)getData{
    _dataArray =@[@{@"title":@"我的VIP",@"image":@"vip_icon"},
                  @{@"title":@"我的活动",@"image":@"hd"},
                  @{@"title":@"我的订单",@"image":@"dingdan_icon"},
                  @{@"title":@"消息中心",@"image":@"xiaoxi_icon"},
                  @{@"title":@"意见反馈",@"image":@"yijian_icon"}];
}

-(void)loadBaseUI{
    [superView addSubview:self.headerView];
    
    CGFloat  width    = 82*LSScale;
    CGFloat  space    = (LSMainScreenW-2*20*LSScale-3*width)/2;
    
    uploadBtn       =[[LsButton alloc] initWithFrame:CGRectMake(20*LSScale, CGRectGetMaxY(self.headerView.frame)+20*LSScale,width, 60*LSScale)];
    uploadBtn.lsImageView.frame  =CGRectMake(0, 0, width, 40*LSScale);
    uploadBtn.lsImageView.image  =[UIImage imageNamed:@"yichuan_icon"];
    uploadBtn.lsLabel.frame      =CGRectMake(0,CGRectGetMaxY(uploadBtn.lsImageView.frame), width, 20*LSScale);
    uploadBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    uploadBtn.lsLabel.font       =[UIFont systemFontOfSize:12.5*LSScale];
    uploadBtn.lsLabel.text       =@"已传视频";
    uploadBtn.tag                =123;
    [uploadBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:uploadBtn];
    
    LsButton   * myLiveBtn       =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(uploadBtn.frame)+space, CGRectGetMaxY(self.headerView.frame)+20*LSScale,width, 60*LSScale)];
    myLiveBtn.lsImageView.frame  =CGRectMake(0, 0, width, 40*LSScale);
    myLiveBtn.lsImageView.image  =[UIImage imageNamed:@"zhibo_icon"];
    myLiveBtn.lsLabel.frame      =CGRectMake(0,CGRectGetMaxY(uploadBtn.lsImageView.frame), width, 20*LSScale);
    myLiveBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    myLiveBtn.lsLabel.font       =[UIFont systemFontOfSize:12.5*LSScale];
    myLiveBtn.lsLabel.text       =@"我的直播";
    myLiveBtn.tag                =124;
    [myLiveBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:myLiveBtn];
    
    LsButton   * collectionBtn       =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myLiveBtn.frame)+space, CGRectGetMaxY(self.headerView.frame)+20*LSScale,width, 60*LSScale)];
    collectionBtn.lsImageView.frame  =CGRectMake(0, 0, width, 40*LSScale);
    collectionBtn.lsImageView.image  =[UIImage imageNamed:@"shoucang_icon"];
    collectionBtn.lsLabel.frame      =CGRectMake(0,CGRectGetMaxY(uploadBtn.lsImageView.frame), width, 20*LSScale);
    collectionBtn.lsLabel.textAlignment =NSTextAlignmentCenter;
    collectionBtn.lsLabel.font       =[UIFont systemFontOfSize:12.5*LSScale];
    collectionBtn.lsLabel.text       =@"我的收藏";
    collectionBtn.tag                =125;
    [collectionBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:collectionBtn];
    
    [superView addSubview:self.tabView];
}

-(void)clickBtn:(LsButton*)button{
    if (button.tag ==123) {
        [LsMethod alertMessage:@"已上传" WithTime:1];
    }else if (button.tag ==124){
        [LsMethod alertMessage:@"我的直播" WithTime:1];
    }else{
        [LsMethod alertMessage:@"我的收藏" WithTime:1];
    }
}

- (void)clickMyHeaderViewIndex:(NSInteger)index{
    
    if (index==0) {
        [LsMethod alertMessage:@"个人修改" WithTime:1];
    }else{
        [LsMethod alertMessage:@"考试目标" WithTime:1];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45*LSScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *sectionIDD = @"section1";
    LsMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionIDD];
    if (!cell) {
        cell = [[LsMyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionIDD];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell reloadCellWithData:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        LsFeedBackViewController *vc =[[LsFeedBackViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    [LsMethod alertMessage:_dataArray[indexPath.row][@"title"] WithTime:1];

}

-(LsMyHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[LsMyHeaderView alloc] initWithFrame:CGRectMake(10*LSScale, 15*LSScale+CGRectGetMaxY(self.navView.frame), LSMainScreenW-20*LSScale, 110*LSScale)];
        _headerView.backgroundColor  =[UIColor whiteColor];
        _headerView.delegate=self;
    }
    return _headerView;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(uploadBtn.frame)+20*LSScale, LSMainScreenW-20*LSScale,45*LSScale*5)];
        _tabView.delegate                      =self;
        _tabView.dataSource                    =self;
        _tabView.tableFooterView               =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator  =NO;
        _tabView.backgroundColor               =[UIColor whiteColor];
        _tabView.layer.cornerRadius            =6*LSScale;
        _tabView.scrollEnabled                 =NO;
    }
    return _tabView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
