//
//  LsConfigureViewController.m
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsConfigureViewController.h"
#import "LsCollectionHeaderView.h"
#import "LsBaseCollectionViewCell.h"
#import "LsConfigureModel.h"
#import "LsConfigureTwoViewController.h"

static NSString * reuseIdentifier = @"Cell";
static NSString * headerReuseIdentifier = @"header";

@interface LsConfigureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray           *headerArray;
    UICollectionView  *myCollectionView3;
    UIScrollView      *scrollView;
    NSInteger         indexCollectView;
    UIButton          *saveBtn;
    UILabel           *bottomL;
}
@property (nonatomic,strong)  LsConfigureModel     *model;
@property (nonatomic,strong)  NSMutableDictionary  *dataDict;

@end

@implementation LsConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [superView addSubview:self.navView];
    self.navView.navTitle =@"确认我的梦想(1/2)";
    headerArray =@[@"您参加的考试?",@"您教学的目标?",@"您教授的科目是?"];
    [self loginRequest];
    [superView bringSubviewToFront:self.navView];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSGET:@"listallsetting.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model = [LsConfigureModel yy_modelWithJSON:responseObject];
        [self.model fromDict:responseObject];
        LsLog(@"------------%@",self.model);
        [self initBaseUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)loginRequest{
    NSDictionary *dict  =@{@"mobile":@"17507120068",
                           @"password":@"lzl123456"};
    [[LsAFNetWorkTool shareManger] LSGET:@"mobilelogin.html" parameters:dict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        LsLog(@"----------登录成功---------%@",responseObject);
        [self getData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)initBaseUI{
    scrollView          =[[UIScrollView alloc] init];
    scrollView.frame    =superView.frame;
    scrollView.showsVerticalScrollIndicator   =NO;
    [superView  addSubview:scrollView];
    UILabel *label      =[[UILabel alloc] initWithFrame:CGRectMake(65, 40+CGRectGetMaxY(self.navView.frame), LSMainScreenW-130, 60)];
    label.text          =@"只需三秒\n让良师说更合适你";
    label.numberOfLines =0;
    label.textAlignment =NSTextAlignmentCenter;
    label.font          =[UIFont systemFontOfSize:23];
    label.textColor     =LSNavColor;
    [scrollView addSubview:label];
    
    UICollectionViewFlowLayout *flowlaout1=[[UICollectionViewFlowLayout alloc]init];
    [flowlaout1 setScrollDirection:UICollectionViewScrollDirectionVertical];//垂直方向
    flowlaout1.minimumLineSpacing = 5;//设置最小行间距
    flowlaout1.minimumInteritemSpacing = 5;//item间距(最小值)
    
    UICollectionView * myCollectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame)+30, LSMainScreenW-40,70)
                                         collectionViewLayout:flowlaout1];
    [myCollectionView1 registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [myCollectionView1 registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    myCollectionView1.delegate=self;
    myCollectionView1.dataSource=self;
    myCollectionView1.tag       =11111;
    myCollectionView1.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:myCollectionView1];
    
    UICollectionViewFlowLayout *flowlaout2=[[UICollectionViewFlowLayout alloc]init];
    [flowlaout2 setScrollDirection:UICollectionViewScrollDirectionVertical];//垂直方向
    flowlaout2.minimumLineSpacing = 5;//设置最小行间距
    flowlaout2.minimumInteritemSpacing = 5;//item间距(最小值)
    
    UICollectionView * myCollectionView2=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(myCollectionView1.frame)+10, LSMainScreenW-40,70)
                                         collectionViewLayout:flowlaout2];
    [myCollectionView2 registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [myCollectionView2 registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    myCollectionView2.delegate=self;
    myCollectionView2.dataSource=self;
    myCollectionView2.tag =22222;
    myCollectionView2.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:myCollectionView2];

    UICollectionViewFlowLayout *flowlaout3=[[UICollectionViewFlowLayout alloc]init];
    [flowlaout3 setScrollDirection:UICollectionViewScrollDirectionVertical];//垂直方向
    flowlaout3.minimumLineSpacing = 5;//设置最小行间距
    flowlaout3.minimumInteritemSpacing = 5;//item间距(最小值)
    
    myCollectionView3=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(myCollectionView2.frame)+10, LSMainScreenW-40,10)
                                         collectionViewLayout:flowlaout3];
    [myCollectionView3 registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [myCollectionView3 registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    myCollectionView3.backgroundColor=[UIColor whiteColor];
    myCollectionView3.delegate=self;
    myCollectionView3.dataSource=self;
    myCollectionView3.tag =33333;
    [scrollView addSubview:myCollectionView3];

     [myCollectionView1 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [myCollectionView2 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [myCollectionView3 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];

    saveBtn =[[UIButton alloc] init];
    [saveBtn setTitle:@"保存我的梦想" forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius =5;
    saveBtn.layer.backgroundColor =LSNavColor.CGColor;
    [saveBtn addTarget:self action:@selector(saveConfigureBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:saveBtn];
    
    bottomL   =[[UILabel alloc] init];
    bottomL.text        =@"学习过程中,您可通过个人设置进行修改";
    bottomL.textColor   =LSColor(114, 113, 114, 1);
    bottomL.font        =[UIFont systemFontOfSize:10];
    bottomL.textAlignment =NSTextAlignmentCenter;
    [scrollView addSubview:bottomL];

    [self resetFrame];
}

-(void)resetFrame{
    NSInteger rowNum =0;
    if ([[self.model.levels[indexCollectView] subjectArray] count]>0) {
         rowNum =[[self.model.levels[indexCollectView] subjectArray]count]/4+1;
    }
    myCollectionView3.frame =CGRectMake(20,myCollectionView3.frame.origin.y, LSMainScreenW-40,30+40*rowNum);
    saveBtn.frame =CGRectMake(35, CGRectGetMaxY(myCollectionView3.frame)+ 20, LSMainScreenW-70, 35*LSScale);
    bottomL.frame =CGRectMake(35, CGRectGetMaxY(saveBtn.frame)+10, LSMainScreenW-70, 20*LSScale);
    [scrollView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(bottomL.frame)+65)];
}

-(void)saveConfigureBtn{
    LsBaseConfigureModel  *aaa =[self.dataDict objectForKey:@"catgs"];
    LsBaseConfigureModel  *bbb =[self.dataDict objectForKey:@"levels"];
    [LsMethod alertMessage:aaa.name AndTitle:bbb.name];
    LsLog(@"----------%@--------%@:%@",aaa.name,bbb.name,bbb.level);

//    LsConfigureTwoViewController *vc =[[LsConfigureTwoViewController alloc] init];
//    vc.dataDict                      =self.dataDict;
//    vc.modalPresentationStyle        =UIModalPresentationCustom;
//    vc.modalTransitionStyle          =UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:vc animated:YES completion:nil];
}

#pragma - mark -  collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==11111) {
        return  self.model.catgs.count;
    }else if (collectionView.tag==22222){
        return self.model.levels.count;
    }else{
        return [[self.model.levels[indexCollectView] subjectArray] count];
    }
}

//cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==11111) {
        if (self.model.catgs.count>3) {
            return CGSizeMake((LSMainScreenW-40-15)/4,35);
        }else{
            return CGSizeMake((LSMainScreenW-40-15)/3,35);
        }
    }else{
        return CGSizeMake((LSMainScreenW-40-15)/4,35);
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LsBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    if (cell) {
        LsBaseConfigureModel *modelll =[[LsBaseConfigureModel alloc] init];
        if (collectionView.tag==11111) {
            modelll =self.model.catgs[indexPath.row];
        }else if (collectionView.tag==22222){
            modelll =self.model.levels[indexPath.row];
        }else{
            modelll =[self.model.levels[indexCollectView] subjectArray][indexPath.row];
        }
        cell.label.text =modelll.name;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LsBaseConfigureModel *modelll =[[LsBaseConfigureModel alloc] init];
    if (collectionView.tag==11111) {
        modelll                   =self.model.catgs[indexPath.row];
        [self.dataDict setObject:self.model.catgs[indexPath.row]  forKey:@"catgs"];
    }else if (collectionView.tag==22222){
        modelll                   =self.model.levels[indexPath.row];
        indexCollectView          =indexPath.row;
        [myCollectionView3        reloadData];
        [myCollectionView3 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        if ([[self.model.levels[indexPath.row] subjectArray] count]>0) {
            [self.dataDict setObject:[self.model.levels[indexPath.row] subjectArray][0] forKey:@"levels"];
        }
    }else{
        modelll                   =[self.model.levels[indexCollectView] subjectArray][indexPath.row];
        [self.dataDict setObject:[self.model.levels[indexCollectView] subjectArray][indexPath.row] forKey:@"levels"];
    }
    [self resetFrame];
}

#pragma - mark -  collectionHeaderView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(LSMainScreenW, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
    UICollectionReusableView *reusableview = [UICollectionReusableView new];
    if (kind == UICollectionElementKindSectionHeader) {
        LsCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        if (collectionView.tag==11111) {
            headerView.label.text =headerArray[0];
        }else if (collectionView.tag==22222){
            headerView.label.text =headerArray[1];
        }else{
            headerView.label.text =headerArray[2];
        }
        reusableview = headerView;
    }
    return reusableview;
}

-(LsConfigureModel *)model{
    if (!_model) {
        _model =[[LsConfigureModel alloc] init];
    }
    return _model;
}

-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict =[NSMutableDictionary dictionary];
        [_dataDict setObject:self.model.catgs[0]  forKey:@"catgs"];
        [_dataDict setObject:[self.model.levels[0] subjectArray][0] forKey:@"levels"];
    }
    return _dataDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
