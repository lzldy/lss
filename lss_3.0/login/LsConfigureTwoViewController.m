//
//  LsConfigureTwoViewController.m
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsConfigureTwoViewController.h"
#import "LsCollectionHeaderView.h"
#import "LsBaseCollectionViewCell.h"
#import "LsConfigureModel.h"

static NSString * reuseIdentifier = @"Cell";
static NSString * headerReuseIdentifier = @"header";

@interface LsConfigureTwoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray           *headerArray;
    NSMutableArray    *allDataArray;
}
@property (nonatomic,strong)  LsBaseConfigureModel  *model;

@end

@implementation LsConfigureTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [superView addSubview:self.navView];
    self.navView.navTitle =@"确认我的梦想(2/2)";
    [self initData];
    [self initBaseUI];
}

-(void)initData{
    headerArray               =@[@"已开通线下分校省份",@"其他省份 (暂时没有线下分校,但是学习内容依然完善)"];
    allDataArray              =[NSMutableArray array];
    NSMutableArray *openedArr =[NSMutableArray array];
    NSMutableArray *closedArr =[NSMutableArray array];

    for (LsBaseConfigureModel *modelll in self.brachsArray) {
        if ([modelll.status isEqualToString:@"Y"]) {
            [openedArr addObject:modelll];
        }else{
            [closedArr addObject:modelll];
        }
    }
    [allDataArray addObject:openedArr];
    [allDataArray addObject:closedArr];
}

-(void)initBaseUI{
    UILabel *label      =[[UILabel alloc] initWithFrame:CGRectMake(30, 40+CGRectGetMaxY(self.navView.frame), LSMainScreenW-60, 60)];
    label.text          =@"最后一步\n个性化学习内容即将呈现";
    label.numberOfLines =0;
    label.textAlignment =NSTextAlignmentCenter;
    label.font          =[UIFont systemFontOfSize:23];
    label.textColor     =LSNavColor;
    [superView addSubview:label];
    
    UICollectionViewFlowLayout *flowlaout=[[UICollectionViewFlowLayout alloc]init];
    [flowlaout setScrollDirection:UICollectionViewScrollDirectionVertical];//垂直方向
    flowlaout.minimumLineSpacing = 5;//设置最小行间距
    flowlaout.minimumInteritemSpacing = 5;//item间距(最小值)
    flowlaout.sectionInset          =UIEdgeInsetsMake(0, 0, 30, 0);
    
    UICollectionView * myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame)+30, LSMainScreenW-40,LSMainScreenH-30-CGRectGetMaxY(label.frame))
                                                            collectionViewLayout:flowlaout];
    [myCollectionView registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [myCollectionView registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    myCollectionView.delegate=self;
    myCollectionView.dataSource=self;
    myCollectionView.showsVerticalScrollIndicator=NO;
    myCollectionView.backgroundColor=[UIColor whiteColor];
    [superView addSubview:myCollectionView];
}

#pragma - mark -  collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return allDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [allDataArray[section] count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((LSMainScreenW-40-15)/4,35);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LsBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    if (cell) {
        self.model      =allDataArray[indexPath.section][indexPath.row];
        cell.label.text =self.model.name;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.model    =allDataArray[indexPath.section][indexPath.row];
    [self.dataDict setObject:self.model.id_ forKey:@"branchid"];
    [LSUser_Default setObject:@"yes" forKey:@"didConfig"];
    LsLog(@"==========================%@",self.dataDict);
    [self settingRequest];
}

-(void)settingRequest{
    [[LsAFNetWorkTool shareManger] LSPOST:@"updateallsetting.html" parameters:self.dataDict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self settingSuccess];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)settingSuccess{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    LsAppDelegate *appdele=(LsAppDelegate*)[UIApplication sharedApplication].delegate;
    [appdele loadMianTab];
}

#pragma - mark -  collectionHeaderView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(LSMainScreenW, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = [UICollectionReusableView new];
    if (kind == UICollectionElementKindSectionHeader) {
        LsCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        headerView.label.text      =headerArray[indexPath.section];
        headerView.label.textColor =[UIColor darkTextColor];
        headerView.label.font      =[UIFont systemFontOfSize:13];
        if (indexPath.section==1) {
            NSString *str=headerArray[indexPath.section];
            NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:str];
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:LSColor(102, 102, 102, 1)
                                     range:NSMakeRange(5,str.length-5)];
            [attributedString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:11]
                                     range:NSMakeRange(5,str.length-5)];
            headerView.label.attributedText=attributedString;
        }
        reusableview = headerView;
    }
    return reusableview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LsBaseConfigureModel *)model{
    if (!_model) {
        _model =[[LsBaseConfigureModel alloc] init];
    }
    return _model;
}

@end
