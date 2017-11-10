//
//  LsPractiveDetailViewController.m
//  lss
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPractiveDetailViewController.h"
#import "LsCommentTableViewCell.h"
#import "LsCommentViewController.h"
#import "LsCommentView.h"
#import "LsCustomPlayerViewController.h"
#import "LsPracticeDetailModel.h"
#import "DWCustomPlayerViewController.h"

@interface LsPractiveDetailViewController ()<UITableViewDelegate,UITableViewDataSource,commentViewDelegate>
{
    UIView   *blackGroudView;
    UIButton *goodBtn;
}
@property (nonatomic,strong) UITableView *tabView;
@property (nonatomic,strong) LsPracticeDetailModel *model;
@property (nonatomic,strong) LsCustomPlayerViewController *childVC;

@end

@implementation LsPractiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor  =LSColor(243, 244, 245, 1);
    
    [self.navView.rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"fx"] forState:UIControlStateSelected];
    [self.navView.rightButton addTarget:self action:@selector(didClickNavViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navView.navTitle =self.authorType;
    [self addPlayCount];
    [self getData];
}

-(void)getData{
    NSDictionary *dict =@{@"code":self.code_};
    [[LsAFNetWorkTool shareManger] LSPOST:@"getvideotable.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model  =[LsPracticeDetailModel yy_modelWithDictionary:[responseObject objectForKey:@"data"] ];
        [self loadBaseUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)loadBaseUI{
    self.childVC                   =[[LsCustomPlayerViewController alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenW*LSScaleW_H)];
    [self addChildViewController:self.childVC];
    self.childVC.videoId           =self.videoID;
    [superView addSubview:self.childVC.view];

//    UIButton *videoBtn             =[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenW*LSScaleW_H)];
//    videoBtn.backgroundColor       =[UIColor greenColor];
//    [videoBtn setImage:[UIImage imageNamed:@"banner1.jpg"] forState:0];
//    videoBtn.tag           =1314;
//    videoBtn.adjustsImageWhenHighlighted = NO;
//    [videoBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [superView addSubview:videoBtn];
    
//    UIImage *bf_image              =[UIImage imageNamed:@"bf_button"];
//    UIImageView    *playBtn        =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bf_image.size.width, bf_image.size.height)];
//    playBtn.center                 =self.childVC.view.center;
//    playBtn.image                  =bf_image;
//    [superView addSubview:playBtn];
    
    UIView   *headerView           =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_childVC.view.frame), LSMainScreenW, 50*LSScale)];
    headerView.backgroundColor     =[UIColor whiteColor];
    [superView addSubview:headerView];

    UILabel  *titleL               =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 5*LSScale, LSMainScreenW/2+30*LSScale, 20*LSScale)];
    titleL.text                    =self.model.title;
    titleL.font                    =[UIFont systemFontOfSize:13*LSScale];
    titleL.textColor               =[UIColor darkTextColor];
    [headerView addSubview:titleL];
    
    UILabel  *uploadTimeL         =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, headerView.frame.size.height/2, LSMainScreenW, 20*LSScale)];
    NSString  *uploadTimeStr      =[LsMethod toDateWithTimeStamp:self.model.startDate DateFormat:@"yyyy年MM月dd日"];
    uploadTimeL.text              =[NSString stringWithFormat:@"共%@人观看   %@发布",self.model.viewtime,uploadTimeStr];
    uploadTimeL.font              =[UIFont systemFontOfSize:12*LSScale];
    uploadTimeL.textColor         =[UIColor darkGrayColor];
    [headerView addSubview:uploadTimeL];
    
    UIButton *comBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-10*LSScale-45*LSScale, 5*LSScale, 45*LSScale, 20*LSScale)];
    [comBtn setImage:[UIImage imageNamed:@"dx_icon"]    forState:UIControlStateNormal];
    [comBtn setTitle:self.model.commentNum forState:UIControlStateNormal];
    comBtn.titleLabel.font   =[UIFont systemFontOfSize:12*LSScale];
    [comBtn setTitleColor:[UIColor darkTextColor]       forState:UIControlStateNormal];
    comBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [comBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0.0,0.0)];
    comBtn.adjustsImageWhenHighlighted = NO;
    [comBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    comBtn.tag  =567;
    [headerView addSubview:comBtn];
    
    goodBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-55*LSScale-45*LSScale,5*LSScale, 45*LSScale, 20*LSScale)];
    [goodBtn setImage:[UIImage imageNamed:@"dz_icon"] forState:UIControlStateNormal];
    [goodBtn setImage:[UIImage imageNamed:@"dz_icon_xz"] forState:UIControlStateSelected];
    [goodBtn setTitle:self.model.zannum forState:UIControlStateNormal];
    goodBtn.titleLabel.font   =[UIFont systemFontOfSize:12*LSScale];
    [goodBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [goodBtn setTitleColor:LSNavColor forState:UIControlStateSelected];
    goodBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [goodBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,5, 0.0,0.0)];
    goodBtn.tag   =765;
    goodBtn.adjustsImageWhenHighlighted = NO;
    [goodBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:goodBtn];
    
    UIView  *commentView           =[[UIView alloc] init];
    commentView.backgroundColor    =[UIColor whiteColor];
    [superView addSubview:commentView];
    
    UILabel *reviewL               =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 0, LSMainScreenW/2+30*LSScale, 40*LSScale)];
    reviewL.text              =@"该视频共有5位老师点评";
    reviewL.font              =[UIFont systemFontOfSize:15*LSScale];
    reviewL.textColor         =[UIColor darkTextColor];
    [commentView addSubview:reviewL];
    
    UIButton *seeCommentBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-15*LSScale-100*LSScale,0, 100*LSScale, 40*LSScale)];
    [seeCommentBtn setImage:[UIImage imageNamed:@"jj_button"] forState:UIControlStateNormal];
    [seeCommentBtn setTitle:@"查看全部点评" forState:UIControlStateNormal];
    seeCommentBtn.titleLabel.font   =[UIFont systemFontOfSize:15*LSScale];
    [seeCommentBtn setTitleColor:LSNavColor forState:UIControlStateNormal];
    seeCommentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    seeCommentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, seeCommentBtn.frame.size.width - seeCommentBtn.imageView.frame.origin.x - seeCommentBtn.imageView.frame.size.width, 0, 0);
    seeCommentBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-18*LSScale, 0, 0);
    seeCommentBtn.tag   =555;
    [seeCommentBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:seeCommentBtn];
    
    _tabView                       =[[UITableView alloc] init];
    _tabView.delegate              =self;
    _tabView.dataSource            =self;
    _tabView.tableFooterView       =[[UIView alloc] init];
    _tabView.showsVerticalScrollIndicator   =NO;
    _tabView.separatorStyle        =UITableViewCellSeparatorStyleNone;//去线
    //增加上拉下拉刷新事件
    [_tabView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [_tabView addFooterWithTarget:self action:@selector(footerRefresh)];
    [superView addSubview:_tabView];
    
    if ([self.authorType isEqualToString:@"学生"]) {
        commentView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame)+10*LSScale, LSMainScreenW, 40*LSScale);
        _tabView.frame    = CGRectMake(0, CGRectGetMaxY(commentView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-10*LSScale-CGRectGetMaxY(commentView.frame));
    }else{
//        UIButton *introductionBtn =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-15*LSScale-70*LSScale,CGRectGetMaxY(goodBtn.frame), 70*LSScale, 20*LSScale)];
//        [introductionBtn setImage:[UIImage imageNamed:@"jj_button"] forState:UIControlStateNormal];
//        [introductionBtn setTitle:@"查看简介" forState:UIControlStateNormal];
//        introductionBtn.titleLabel.font   =[UIFont systemFontOfSize:12.5*LSScale];
//        [introductionBtn setTitleColor:LSNavColor forState:UIControlStateNormal];
//        introductionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        introductionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, introductionBtn.frame.size.width - introductionBtn.imageView.frame.origin.x - introductionBtn.imageView.frame.size.width, 0, 0);
//        introductionBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-13*LSScale, 0, 0);
//        introductionBtn.tag   =8008;
//        [introductionBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [headerView addSubview:introductionBtn];
        
        commentView.hidden  =YES;
        _tabView.frame    = CGRectMake(0, CGRectGetMaxY(commentView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-10*LSScale-CGRectGetMaxY(commentView.frame));

//        _tabView.frame    = CGRectMake(0, CGRectGetMaxY(headerView.frame)+10*LSScale, LSMainScreenW, LSMainScreenH-10*LSScale-CGRectGetMaxY(headerView.frame));
    }
    
    UIButton  *commentBtn        =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-15*LSScale-50*LSScale, LSMainScreenH-30*LSScale-50*LSScale, 50*LSScale, 50*LSScale)];
    [commentBtn setImage:[UIImage imageNamed:@"pl"] forState:0];
    [commentBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.tag   =888;
    [superView addSubview:commentBtn];
    [superView bringSubviewToFront:self.childVC.view];
}

-(void)didClickNavViewRightBtn:(UIButton*)button{
    [LsMethod alertMessage:@"分享" WithTime:1.5];
}

-(void)clickBtn:(UIButton *)button{
    if (button.tag==765) {
        if (button.selected==NO) {
            button.selected=YES;
            [self zanVideo];
        }
    }else if(button.tag ==555){
        
        LsCommentViewController *comVc =[[LsCommentViewController alloc] init];
        [self.navigationController  pushViewController:comVc animated:YES];
    }else if(button.tag== 888){
        LsCommentView *commentView     =[[LsCommentView alloc] init];
        commentView.delegate           =self;
        commentView.textPlaceholder    =@"写下您此刻的想法······";
        commentView.commitBtnText      =@"发送评论";
        [superView addSubview:commentView];
    }else if (button.tag ==1314){
//        DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
//        player.playMode = NO;
//        player.videoId = @"2DBC15008476D84C9C33DC5901307461";
////        player.videos = self.videoIds;
////        player.indexpath = indexPath;
////        player.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:player animated:NO];
        
        LsCustomPlayerViewController *playVc =[[LsCustomPlayerViewController alloc] init];
        [self.navigationController pushViewController:playVc animated:YES];
    }else if (button.tag ==8008){
        [self initIntroductionView];
    }else if (button.tag ==999){
        [blackGroudView removeFromSuperview];
    }
}

-(void)initIntroductionView{
    blackGroudView  =[[UIView alloc] initWithFrame:superView.bounds];
    blackGroudView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [superView addSubview:blackGroudView];
    
    UIScrollView *introductionView =[[UIScrollView alloc] initWithFrame:CGRectMake(0,LSMainScreenH, LSMainScreenW, CGRectGetHeight(self.tabView.frame))];
    introductionView.backgroundColor  =[UIColor whiteColor];
    [blackGroudView addSubview:introductionView];

    UIImage   *btnImage    =[UIImage imageNamed:@"gb_introduction"];
    UIButton  *closeBtn    =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-10*LSScale-btnImage.size.width, 10*LSScale, btnImage.size.width, btnImage.size.height)];
    [closeBtn setImage:btnImage forState:0];
    [closeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag           =999;
    [introductionView addSubview:closeBtn];
    
    [UIView  animateWithDuration:0.3 animations:^{
        introductionView.frame  =CGRectMake(0,  CGRectGetMinY(self.tabView.frame), LSMainScreenW, CGRectGetHeight(self.tabView.frame));
    }];
}

- (void)didClickCommitButton:(NSString*)text{
    [self commentVideoWithText:text];
}

-(void)addPlayCount{
    NSDictionary *dict =@{@"code":self.code_};
    [[LsAFNetWorkTool shareManger] LSPOST:@"playvideotable.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)zanVideo{
    NSDictionary *dict =@{@"code":self.code_,@"zanflag":@"yes"};
    [[LsAFNetWorkTool shareManger] LSPOST:@"zanvideotable.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [goodBtn setTitle:[NSString stringWithFormat:@"%ld",[self.model.zannum integerValue] +1] forState:0];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)commentVideoWithText:(NSString *)text{
    NSDictionary *dict =@{@"code":self.code_,@"comment":text,@"commentid":@""};
    [[LsAFNetWorkTool shareManger] LSPOST:@"commentvideotable.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
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
//    LsPracticeListModel *model =self.model.practiceDataArray[indexPath.row];
    [cell reloadCellWithData:nil type:@"0"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LsPracticeListModel *model            =self.model.practiceDataArray[indexPath.row];
//    LsPractiveDetailViewController *praVc =[[LsPractiveDetailViewController alloc] init];
//    //    praVc.authorType                      =model.authorType ;
//    praVc.authorType                      =@"学生";
//    [self.navigationController pushViewController:praVc animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [blackGroudView removeFromSuperview];
}

-(LsPracticeDetailModel *)model{
    if (!_model) {
        _model =[[LsPracticeDetailModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
