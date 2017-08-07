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

static NSString * reuseIdentifier1 = @"Cell1";
static NSString * reuseIdentifier2 = @"Cell2";
static NSString * reuseIdentifier3 = @"Cell3";

static NSString * headerReuseIdentifier = @"header";

@interface LsConfigureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray    *kemuArray;
    NSMutableArray    *kaoshiArray;
    NSMutableArray    *mubiaoArray;
    NSArray           *headerArray;
    UICollectionView  *myCollectionView3;
    UIScrollView      *scrollView;
    NSInteger         indexCollectView;
    UIButton          *saveBtn;
    UILabel           *bottomL;
}
@property (nonatomic,strong)  NSMutableArray    *allDataArray;
@property (nonatomic,strong)  LsConfigureModel  *model;

@end

@implementation LsConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [superView addSubview:self.navView];
    self.navView.navTitle =@"确认我的梦想(1/2)";
    [self initData];
    [self initBaseUI];
    [superView bringSubviewToFront:self.navView];
}

-(void)initData{
    kemuArray   =[NSMutableArray array];
    kaoshiArray =[NSMutableArray array];
    mubiaoArray =[NSMutableArray array];

    NSArray * kaoshiArr =@[@{@"title":@"教师资格证",@"didSelect":@"yes"},
                         @{@"title":@"教师招聘",@"didSelect":@"no"},
                         @{@"title":@"选调教师",@"didSelect":@"no"}];
    
    for (NSDictionary *dict in kaoshiArr) {
        self.model = [LsConfigureModel yy_modelWithDictionary:dict];
        [kaoshiArray addObject:self.model];
    }
    
    NSArray * mubiaoArr =@[@{@"title":@"初中",@"didSelect":@"yes"},
                         @{@"title":@"高中",@"didSelect":@"no"},
                         @{@"title":@"小学",@"didSelect":@"no"},
                         @{@"title":@"幼儿",@"didSelect":@"no"}];
   
    for (NSDictionary *dict in mubiaoArr) {
        self.model = [LsConfigureModel yy_modelWithDictionary:dict];
        [mubiaoArray addObject:self.model];
    }

   NSArray*kemuArr=@[@[@{@"title":@"语文",@"didSelect":@"yes"},@{@"title":@"数学",@"didSelect":@"no"},
                     @{@"title":@"英语",@"didSelect":@"no"},@{@"title":@"物理",@"didSelect":@"no"},
                     @{@"title":@"音乐",@"didSelect":@"no"},@{@"title":@"地理",@"didSelect":@"no"},
                     @{@"title":@"政治",@"didSelect":@"no"},@{@"title":@"历史",@"didSelect":@"no"},
                     @{@"title":@"美术",@"didSelect":@"no"},@{@"title":@"生物",@"didSelect":@"no"},
                     @{@"title":@"信息",@"didSelect":@"no"},@{@"title":@"化学",@"didSelect":@"no"},
                     @{@"title":@"体育",@"didSelect":@"no"}],
                   @[@{@"title":@"语文",@"didSelect":@"yes"},@{@"title":@"数学",@"didSelect":@"no"},
                     @{@"title":@"英语",@"didSelect":@"no"},@{@"title":@"物理",@"didSelect":@"no"},
                     @{@"title":@"音乐",@"didSelect":@"no"},@{@"title":@"地理",@"didSelect":@"no"},
                     @{@"title":@"政治",@"didSelect":@"no"},@{@"title":@"历史",@"didSelect":@"no"},
                     @{@"title":@"美术",@"didSelect":@"no"},@{@"title":@"生物",@"didSelect":@"no"},
                     @{@"title":@"信息",@"didSelect":@"no"},@{@"title":@"化学",@"didSelect":@"no"},
                     @{@"title":@"体育",@"didSelect":@"no"}],
                   @[@{@"title":@"语文",@"didSelect":@"yes"},@{@"title":@"数学",@"didSelect":@"no"},
                     @{@"title":@"英语",@"didSelect":@"no"},@{@"title":@"音乐",@"didSelect":@"no"},
                     @{@"title":@"品德",@"didSelect":@"no"},@{@"title":@"美术",@"didSelect":@"no"},
                     @{@"title":@"体育",@"didSelect":@"no"},@{@"title":@"科学",@"didSelect":@"no"}],
                   @[@{@"title":@"综合",@"didSelect":@"yes"}]
                  ];
    
    for (NSArray *array in kemuArr) {
        NSMutableArray *arr=[NSMutableArray array];
        for (NSDictionary *dcit in array) {
            self.model = [LsConfigureModel yy_modelWithDictionary:dcit];
            [arr addObject:self.model];
        }
        [kemuArray addObject:arr];
    }
    
    headerArray =@[@"您参加的考试?",@"您教学的目标?",@"您教授的科目是?"];
    [self.allDataArray addObject:kaoshiArray];
    [self.allDataArray addObject:mubiaoArray];
    [self.allDataArray addObject:kemuArray];
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
    [myCollectionView1 registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier1];
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
    [myCollectionView2 registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier2];
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
    [myCollectionView3 registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier3];
    [myCollectionView3 registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    myCollectionView3.backgroundColor=[UIColor whiteColor];
    myCollectionView3.delegate=self;
    myCollectionView3.dataSource=self;
    myCollectionView3.tag =33333;
    [scrollView addSubview:myCollectionView3];

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
    NSInteger rowNum =[kemuArray[indexCollectView] count]/4+1;
    myCollectionView3.frame =CGRectMake(20,myCollectionView3.frame.origin.y, LSMainScreenW-40,30+40*rowNum);
    saveBtn.frame =CGRectMake(35, CGRectGetMaxY(myCollectionView3.frame)+ 20, LSMainScreenW-70, 35);
    bottomL.frame =CGRectMake(35, CGRectGetMaxY(saveBtn.frame)+10, LSMainScreenW-70, 20);
    [scrollView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(bottomL.frame)+65)];
}

-(void)saveConfigureBtn{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    for (LsConfigureModel *modelll in kaoshiArray) {
        if (modelll.didSelect==YES) {
            [dict setObject:modelll.title forKey:@"1"];
        }
    }
    for (LsConfigureModel *modelll in mubiaoArray) {
        if (modelll.didSelect==YES) {
            [dict setObject:modelll.title forKey:@"2"];
        }
    }
    for (LsConfigureModel *modelll in kemuArray[indexCollectView]) {
        if (modelll.didSelect==YES) {
            [dict setObject:modelll.title forKey:@"3"];
        }
    }
    LsConfigureTwoViewController *vc =[[LsConfigureTwoViewController alloc] init];
    vc.dataDict                      =dict;
    vc.modalPresentationStyle        =UIModalPresentationCustom;
    vc.modalTransitionStyle          =UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma - mark -  collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==11111) {
        return  kaoshiArray.count;
    }else if (collectionView.tag==22222){
        return mubiaoArray.count;
    }else{
        return [kemuArray[indexCollectView] count];
    }
}

//cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==11111) {
        return CGSizeMake((LSMainScreenW-40-15)/3,35);
    }else{
        return CGSizeMake((LSMainScreenW-40-15)/4,35);
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (collectionView.tag==11111) {
        LsBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        [cell sizeToFit];
        self.model =kaoshiArray[indexPath.row];
        [cell reloadDataWith:self.model];
        return  cell;
    }else if (collectionView.tag==22222){
        LsBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
        [cell sizeToFit];
        self.model =mubiaoArray[indexPath.row];
        [cell reloadDataWith:self.model];
        return  cell;
    }else{
        LsBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier3 forIndexPath:indexPath];
        [cell sizeToFit];
        self.model=kemuArray[indexCollectView][indexPath.row];
        [cell reloadDataWith:self.model];
        return  cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==11111) {
        for (int i=0; i<kaoshiArray.count; i++) {
            self.model =kaoshiArray[i];
            if (i==indexPath.row) {
                self.model.didSelect=YES;
            }else{
                self.model.didSelect=NO;
            }
        }
    }else if (collectionView.tag==22222){
        for (int i=0; i<mubiaoArray.count; i++) {
            self.model =mubiaoArray[i];
            if (i==indexPath.row) {
                self.model.didSelect=YES;
                indexCollectView    =indexPath.row;
            }else{
                self.model.didSelect=NO;
            }
        }
    }else{
        NSArray *array =kemuArray[indexCollectView];
        for (int i=0; i<array.count; i++) {
            self.model =array[i];
            if (i==indexPath.row) {
                self.model.didSelect=YES;
            }else{
                self.model.didSelect=NO;
            }
        }
    }
    [collectionView reloadData];
    [myCollectionView3 reloadData];
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

-(NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray =[NSMutableArray array];
    }
    return _allDataArray;
}

-(LsConfigureModel *)model{
    if (!_model) {
        _model =[[LsConfigureModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
