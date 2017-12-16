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
    UICollectionView  *myCollectionView2;
    UICollectionView  *myCollectionView3;
    UIScrollView      *scrollView;
    NSInteger         indexCatgCollectView;
    NSInteger         indexLevelCollectView;
    UIButton          *saveBtn;
    UILabel           *bottomL;
}
@property (nonatomic,strong)  LsConfigureModel     *model;
@property (nonatomic,strong)  NSMutableDictionary  *dataDict;
@property (nonatomic,strong)  NSMutableDictionary  *saveDict;

@end

@implementation LsConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"确认我的梦想(1/2)";
    headerArray =@[@"您参加的考试?",@"您教学的目标?",@"您教授的科目是?"];
    [self getData];
}

-(void)getData{
    [[LsAFNetWorkTool shareManger] LSGET:@"listallsetting.html" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        self.model = [LsConfigureModel yy_modelWithJSON:responseObject];
        [self.model fromDict:responseObject];
        [self initBaseUI];
        [superView bringSubviewToFront:self.navView];
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
    
    myCollectionView2=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(myCollectionView1.frame)+10, LSMainScreenW-40,70)
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
    [saveBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
    if ([[[self.model.catgs[indexCatgCollectView] levels][indexLevelCollectView] subjects] count]>0) {
         rowNum =[[[self.model.catgs[indexCatgCollectView] levels][indexLevelCollectView] subjects] count]/4+1;
    }
    myCollectionView3.frame =CGRectMake(20,myCollectionView3.frame.origin.y, LSMainScreenW-40,30+40*rowNum);
    saveBtn.frame =CGRectMake(35, CGRectGetMaxY(myCollectionView3.frame)+ 20, LSMainScreenW-70, 35*LSScale);
    bottomL.frame =CGRectMake(35, CGRectGetMaxY(saveBtn.frame)+10, LSMainScreenW-70, 20*LSScale);
    [scrollView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(bottomL.frame)+65)];
}

-(void)saveConfigureBtn{

//    NSString *sadas =[self.dataDict objectForKey:@"catgid"];
//    NSString *fffff =[self.dataDict objectForKey:@"scatgid"];
//    [LsMethod alertMessage:sadas AndTitle:fffff];
    LsConfigureTwoViewController *vc =[[LsConfigureTwoViewController alloc] init];
    vc.dataDict                      =self.dataDict;
    vc.saveDict                      =self.saveDict;
    vc.brachsArray                   =self.model.branchs;
    vc.modalPresentationStyle        =UIModalPresentationCustom;
    vc.modalTransitionStyle          =UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma - mark -  collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==11111) {
        return  self.model.catgs.count;
    }else if (collectionView.tag==22222){
        return [[self.model.catgs[indexCatgCollectView] levels] count];
    }else{
        return [[[self.model.catgs[indexCatgCollectView] levels][indexLevelCollectView] subjects] count];
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
        if (collectionView.tag==11111){
            LsCatgConfigureModel *modelll =[[LsCatgConfigureModel alloc] init];
            modelll =self.model.catgs[indexPath.row];
            cell.label.text =modelll.name;
        }else if (collectionView.tag==22222){
            LsLevelConfigureModel *modelll =[[LsLevelConfigureModel alloc] init];
            modelll =[self.model.catgs[indexCatgCollectView] levels][indexPath.row];
            cell.label.text =modelll.name;

        }else{
            LsSubjectConfigureModel *modelll =[[LsSubjectConfigureModel alloc] init];
            modelll =[[self.model.catgs[indexCatgCollectView] levels][indexLevelCollectView] subjects][indexPath.row];
            cell.label.text =modelll.name;
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==11111) {
        
        LsCatgConfigureModel *modelll =[[LsCatgConfigureModel alloc] init];
        modelll                       =self.model.catgs[indexPath.row];
        indexCatgCollectView          =indexPath.row;
        indexLevelCollectView         =0;
        [self.dataDict setObject:modelll.id_  forKey:@"catgid"];
        [myCollectionView2 reloadData];
        [myCollectionView3 reloadData];
        [myCollectionView2 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [myCollectionView3 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
        [self.saveDict setObject:modelll.name forKey:@"项目"];

    }else if (collectionView.tag==22222){
        LsLevelConfigureModel *modelll =[[LsLevelConfigureModel alloc] init];
        modelll                        =[self.model.catgs[indexCatgCollectView] levels][indexPath.row];
        indexLevelCollectView          =indexPath.row;
        [myCollectionView3        reloadData];
        [myCollectionView3 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        if ([[[self.model.catgs[indexCatgCollectView] levels][indexLevelCollectView] subjects] count]>0) {
            LsSubjectConfigureModel *amodel =modelll.subjects[0];
            [self.dataDict setObject:amodel.id_ forKey:@"scatgid"];
            [self.saveDict setObject:amodel.name  forKey:@"科目"];
        }
        [self.saveDict setObject:modelll.name forKey:@"学段"];

    }else{
        LsSubjectConfigureModel *modelll =[[self.model.catgs[indexCatgCollectView] levels][indexLevelCollectView] subjects][indexPath.row];
        [self.dataDict setObject:modelll.id_ forKey:@"scatgid"];
        
        [self.saveDict setObject:modelll.name  forKey:@"科目"];
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
        LsCatgConfigureModel *model1 =self.model.catgs[0];
        if ([[[self.model.catgs[0] levels][0] subjects] count]>0) {
            LsSubjectConfigureModel *model2 =[[self.model.catgs[0] levels][0] subjects][0];
            [_dataDict setObject:model2.id_  forKey:@"scatgid"];
        }
        [_dataDict setObject:model1.id_  forKey:@"catgid"];
    }
    return _dataDict;
}

-(NSMutableDictionary *)saveDict{
    if (!_saveDict) {
        _saveDict  =[NSMutableDictionary dictionary];
        if ([self.model.catgs count]>0) {
            LsCatgConfigureModel *model1 =self.model.catgs[0];
            [_saveDict setObject:model1.name forKey:@"项目"];
        }
        
        if ([[self.model.catgs[0] levels] count]>0) {
            LsLevelConfigureModel *model2 =[self.model.catgs[0] levels][0];
            [_saveDict setObject:model2.name forKey:@"学段"];
        }

        if ([[[self.model.catgs[0] levels][0] subjects] count]>0) {
            LsSubjectConfigureModel *model3 =[[self.model.catgs[0] levels][0] subjects][0];
            [_saveDict setObject:model3.name  forKey:@"科目"];
        }
    }
    return _saveDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
