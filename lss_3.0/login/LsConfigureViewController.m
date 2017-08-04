//
//  LsConfigureViewController.m
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsConfigureViewController.h"
#import "LsCollectionHeaderView.h"

static NSString * reuseIdentifier = @"Cell";

@interface LsConfigureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *kemuArray;
    NSArray *kaoshiArray;
    NSArray *mubiaoArray;
    NSArray *headerArray;
}
@property (nonatomic,strong)  LsNavView         *navView;
@property (nonatomic,strong)  UICollectionView  *myCollectionView;
@property (nonatomic,strong)  NSMutableArray    *allDataArray;

@end

@implementation LsConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [superView addSubview:self.navView];
    self.navView.navTitle =@"确认我的梦想(1/2)";
    [self initData];
    [self initBaseUI];

}

-(void)initData{
    kaoshiArray =@[@"教师资格证",@"教师招聘"];
    mubiaoArray =@[@"初中",@"高中",@"小学",@"幼儿"];
    kemuArray   =@[@[@"语文",@"数学",@"英语",@"物理",@"音乐",@"地理",@"政治",@"历史",@"美术",@"生物",@"信息"
                       ,@"化学",@"体育"],
                   @[@"语文",@"数学",@"英语",@"物理",@"音乐",@"地理",@"政治",@"历史",@"美术",@"生物",@"信息",@"化学",@"体育"],
                   @[@"语文",@"数学",@"英语",@"音乐",@"品德",@"美术",@"体育"],
                   @[@"综合"]
                  ];
    headerArray =@[@"您参加的考试?",@"您教学的目标?",@"您教授的科目是?"];
    [self.allDataArray addObject:kaoshiArray];
    [self.allDataArray addObject:mubiaoArray];
    [self.allDataArray addObject:kemuArray];
}

-(void)initBaseUI{
    UILabel *label      =[[UILabel alloc] initWithFrame:CGRectMake(65, 40+CGRectGetMaxY(self.navView.frame), LSMainScreenW-130, 60)];
    label.text          =@"只需三秒\n让良师说更合适你";
    label.numberOfLines =0;
    label.textAlignment =NSTextAlignmentCenter;
    label.font          =[UIFont systemFontOfSize:23];
    label.textColor     =LSNavColor;
    [superView addSubview:label];
    
    UICollectionViewFlowLayout *flowlaout=[[UICollectionViewFlowLayout alloc]init];
    [flowlaout setScrollDirection:UICollectionViewScrollDirectionVertical];//垂直方向
    
    _myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame)+30, LSMainScreenW-40,LSMainScreenH-CGRectGetMaxY(label.frame)-30)
                                         collectionViewLayout:flowlaout];
    [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_myCollectionView registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _myCollectionView.backgroundColor=[UIColor whiteColor];
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    [superView addSubview:_myCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    LsLog(@"-------------\n%d",self.allDataArray.count);
    return self.allDataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array =self.allDataArray[section];
    if (section==2) {
        NSArray*arr= array[section];
        LsLog(@"-----------2222--\n%d",arr.count);
        return arr.count;
    }else{
        LsLog(@"-----------3333--\n%d",array.count);
        return array.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        //        NSLog(@"无法创建时打印。。。");
    }
    cell.backgroundColor =[UIColor redColor];
    return  cell;
}

//cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70,35);
}

//每个之间的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(LSMainScreenW, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        LsCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.label.text =headerArray[indexPath.section];
        reusableview = headerView;
    }
    return reusableview;
}

-(LsNavView *)navView{
    if (!_navView) {
        _navView =[[LsNavView alloc] init];
    }
    return _navView;
}

-(NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray =[NSMutableArray array];
    }
    return _allDataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
