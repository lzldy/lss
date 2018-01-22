//
//  LsMyVideosViewController.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyVideosViewController.h"
#import "LsNavTabView.h"
#import "LsMyVideoTableViewCell.h"
#import "LsMyVideoModel.h"
#import "LsRecordingCompletedViewController.h"

@interface LsMyVideosViewController ()<lsNavTabViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,MyVideoTableViewCellDelegate>
{
    BOOL       isScroll;
    float      startY;
    NSInteger  index ;
}

@property (nonatomic,strong)  LsNavTabView             *topTabView;
@property (nonatomic,strong)  UIScrollView             *scrView;
@property (nonatomic,strong)  UITableView              *tabView;
@property (nonatomic,strong)  UITableView              *tabView1;

@property (nonatomic,strong)  LsMyVideoModel           *model;

@property (nonatomic,strong)  NSMutableArray           *didDataArray;
@property (nonatomic,strong)  NSMutableArray           *unDidDataArray;

@end

@implementation LsMyVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"我的视频";
    superView.backgroundColor                  =LSColor(243, 244, 245, 1);
    [self.navView addSubview:self.topTabView];
    [superView addSubview:self.scrView];
    [self.scrView addSubview:self.tabView];
    [self.scrView addSubview:self.tabView1];
    
    [self getDataOfDidUpload];
}

-(void)getDataOfDidUpload{
    NSMutableDictionary *dict  =[NSMutableDictionary dictionary];
    [dict setObject:@"y"           forKey:@"mytableonly"];
    [dict setObject:@"LK"          forKey:@"ctag3"];
    [dict setObject:@"500"         forKey:@"paging"];
    [[LsAFNetWorkTool shareManger] LSPOST:@"listvideotables.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model  =[LsMyVideoModel yy_modelWithJSON:responseObject];
        if (self.model.list.count>0) {
            self.didDataArray     =[NSMutableArray arrayWithArray:self.model.list];
        }else{
            self.didDataArray     =[NSMutableArray array];
        }
        if (self.didDataArray.count>0) {
            [self.tabView reloadData];
            self.bgImageView.hidden  =YES;
            [superView bringSubviewToFront:self.tabView];
        }else{
            self.bgImageView.hidden  =NO;
            [superView bringSubviewToFront:self.bgImageView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)getDataOfNoUpload{
    NSMutableArray *array     =[NSMutableArray arrayWithArray:[LSUser_Default objectForKey:@"videos"]];
    self.unDidDataArray      =[NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        LsMyVideoModel *modelll =[[LsMyVideoModel alloc] init];
        modelll.startTime       =array[i];
        modelll.title           =array[i];
        NSArray*paths           =      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString*path           =[paths objectAtIndex:0];
        NSString*urlPath        =[NSString stringWithFormat:@"file://%@/%@.mov",path,array[i]];
        modelll.image           =[LsMethod thumbnailImageForVideo:[NSURL URLWithString:urlPath] atTime:1];
        [self.unDidDataArray addObject:modelll];
    }
    if (self.unDidDataArray.count>0) {
        [self.tabView1 reloadData];
        self.bgImageView.hidden  =YES;
        [superView bringSubviewToFront:self.tabView1];
    }else{
        self.bgImageView.hidden  =NO;
        [superView bringSubviewToFront:self.bgImageView];
    }
}

#pragma  - mark -  tabview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==110) {
        return self.didDataArray.count;
    }else{
        return self.unDidDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    LsMyVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LsMyVideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       =self;
    }
    if (tableView.tag==110) {
        [cell reloadCell:self.didDataArray[indexPath.row] type:@"1"];
    }else{
        [cell reloadCell:self.unDidDataArray[indexPath.row] type:@"0"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsMyVideoModel *model_;
    if (tableView.tag==110) {
        model_ =self.didDataArray[indexPath.row];
    }else{
        model_=self.unDidDataArray[indexPath.row];
    }
//    LsDataDetailViewController *dataVc =[[LsDataDetailViewController alloc] init];
//    dataVc.title_                      =model_.title;
//    dataVc.ID                          =model_.id_;
//    [self.navigationController pushViewController:dataVc animated:YES];
}

#pragma  - mark -  NavTabView 代理
-(void)lsNavTabViewIndex:(NSInteger)index{
    [self.scrView setContentOffset:CGPointMake(LSMainScreenW*index,0) animated:NO];
    if (index==0) {
        [self getDataOfDidUpload];
    }else{
        [self getDataOfNoUpload];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    float currentPostion = scrollView.contentOffset.y;
    BOOL  upDown = false;
    if (currentPostion - startY > 0 ||startY - currentPostion > 0) {
        startY = currentPostion;
        upDown = YES;
    }else{
        float index =scrollView.contentOffset.x/LSMainScreenW;
        if (isScroll&&!upDown) {
            [self.topTabView tabIndex:index];
            if (index==0) {
                [self getDataOfDidUpload];
            }else{
                [self getDataOfNoUpload];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScroll =YES;
    if (scrollView.contentOffset.y>0) {
        isScroll =NO;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    isScroll =NO;
}

- (void)didClickBtnIndex:(LsButton*)btn{
    if (btn.tag ==0) {
        //删除
        if ([LsMethod haveValue:btn.ID]) {
            [self deleteData:btn.ID];
        }else{
            [self deleteLoacalVideo:btn.videoID];
        }
    }else{
        //重传
        [self reUploadVideo:btn.videoID];
    }
}

-(void)reUploadVideo:(NSString*)videoID{
    NSArray*paths           =      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*path           =[paths objectAtIndex:0];
    NSString*urlPath        =[NSString stringWithFormat:@"file://%@/%@.mov",path,videoID];
    
    LsRecordingCompletedViewController *vc =[[LsRecordingCompletedViewController alloc] init];
    vc.videoPath                           =videoID;
    vc.videoURL                            =[NSURL URLWithString:urlPath];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)deleteLoacalVideo:(NSString*)videoID{
    NSMutableArray *array     =[NSMutableArray arrayWithArray:[LSUser_Default objectForKey:@"videos"]];
    [array removeObject:videoID];
    SaveToUserDefaults(@"videos", array);
    [self getDataOfNoUpload];
}

-(void)deleteData:(NSString*)code{
    NSDictionary  *dict  =@{@"code":code};
    [[LsAFNetWorkTool shareManger] LSPOST:@"delmytable.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self getDataOfDidUpload];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(LsNavTabView *)topTabView{
    if (!_topTabView) {
        _topTabView =[[LsNavTabView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-100, 20+7, 200, 30)];
        _topTabView.dataArray =@[@"已上传",@"未上传"];
        _topTabView.delegate=self;
    }
    return _topTabView;
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+10*LSScale,LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame)-10*LSScale)];
        _scrView.pagingEnabled                    =YES;
        _scrView.contentSize                      =CGSizeMake(LSMainScreenW*2, 0);
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
        _scrView.delegate                         =self;
        _scrView.bounces                          =NO;
    }
    return _scrView;
}

-(UITableView *)tabView{
    if (!_tabView) {
        _tabView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, self.scrView.frame.size.height)];
        _tabView.delegate         =self;
        _tabView.dataSource       =self;
        _tabView.tableFooterView  =[[UIView alloc] init];
        _tabView.showsVerticalScrollIndicator   =NO;
        _tabView.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView.tag              =110;
    }
    return _tabView;
}

-(UITableView *)tabView1{
    if (!_tabView1) {
        _tabView1 =[[UITableView alloc] initWithFrame:CGRectMake(LSMainScreenW, 0, LSMainScreenW, self.scrView.frame.size.height)];
        _tabView1.delegate         =self;
        _tabView1.dataSource       =self;
        _tabView1.tableFooterView  =[[UIView alloc] init];
        _tabView1.showsVerticalScrollIndicator   =NO;
        _tabView1.separatorStyle   =UITableViewCellSeparatorStyleNone;//去线
        _tabView1.tag              =210;
    }
    return _tabView1;
}

-(LsMyVideoModel *)model{
    if (!_model) {
        _model =[[LsMyVideoModel alloc] init];
    }
    return _model;
}

-(NSMutableArray *)didDataArray{
    if (!_didDataArray) {
        _didDataArray =[NSMutableArray array];
    }
    return _didDataArray;
}

-(NSMutableArray *)unDidDataArray{
    if (!_unDidDataArray) {
        _unDidDataArray =[NSMutableArray array];
    }
    return _unDidDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
