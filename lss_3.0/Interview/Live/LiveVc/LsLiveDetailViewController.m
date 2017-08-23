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

@interface LsLiveDetailViewController ()

@property (nonatomic,strong) LsLiveDetailModel *model;
@property (nonatomic,strong) LsLiveDetailHeaderView *headerView;

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
    [superView addSubview:_headerView];
    
}

-(void)getData{
    NSDictionary *dict =@{@"courseid":self.classId};
    [[LsAFNetWorkTool shareManger] LSPOST:@"getcourseinfo.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        _model  =[LsLiveDetailModel yy_modelWithDictionary:[responseObject objectForKey:@"data"]];
        _headerView.model =_model;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
