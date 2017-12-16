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
    UIScrollView      *scrollView;
    UIButton          *saveBtn;
    UILabel           *bottomL;
    UICollectionView  *myCollectionView;
}
@property (nonatomic,strong)  LsBranchConfigureModel  *model;

@end

@implementation LsConfigureTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"确认我的梦想(2/2)";
    [self initData];
    [self initBaseUI];
    [superView bringSubviewToFront:self.navView];
}

-(void)initData{
    headerArray               =@[@"已开通线下分校省份",@"其他省份 (暂时没有线下分校,但是学习内容依然完善)"];
    allDataArray              =[NSMutableArray array];
    NSMutableArray *openedArr =[NSMutableArray array];
    NSMutableArray *closedArr =[NSMutableArray array];

    for (LsBranchConfigureModel *modelll in self.brachsArray) {
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
    scrollView          =[[UIScrollView alloc] init];
    scrollView.frame    =superView.frame;
    scrollView.showsVerticalScrollIndicator   =NO;
    [superView  addSubview:scrollView];
    
    UILabel *label      =[[UILabel alloc] initWithFrame:CGRectMake(30, 40+CGRectGetMaxY(self.navView.frame), LSMainScreenW-60, 60)];
    label.text          =@"最后一步\n个性化学习内容即将呈现";
    label.numberOfLines =0;
    label.textAlignment =NSTextAlignmentCenter;
    label.font          =[UIFont systemFontOfSize:23];
    label.textColor     =LSNavColor;
    [scrollView addSubview:label];
    
    UICollectionViewFlowLayout *flowlaout=[[UICollectionViewFlowLayout alloc]init];
    [flowlaout setScrollDirection:UICollectionViewScrollDirectionVertical];//垂直方向
    flowlaout.minimumLineSpacing         = 5;//设置最小行间距
    flowlaout.minimumInteritemSpacing    = 5;//item间距(最小值)
    flowlaout.sectionInset               =UIEdgeInsetsMake(0, 0, 30, 0);
    
    myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame)+30, LSMainScreenW-40,LSMainScreenH-30-CGRectGetMaxY(label.frame))
                                                            collectionViewLayout:flowlaout];
    [myCollectionView registerClass:[LsBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [myCollectionView registerClass:[LsCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    myCollectionView.delegate                      =self;
    myCollectionView.dataSource                    =self;
    myCollectionView.showsVerticalScrollIndicator  =NO;
    myCollectionView.scrollEnabled                 =NO;
    myCollectionView.backgroundColor               =[UIColor whiteColor];
    [scrollView addSubview:myCollectionView];
    
    saveBtn =[[UIButton alloc] init];
    [saveBtn setTitle:@"保存我的梦想" forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius            =5;
    saveBtn.layer.backgroundColor         =LSLineColor.CGColor;
    saveBtn.userInteractionEnabled        =NO;
    [saveBtn addTarget:self action:@selector(settingRequest) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:saveBtn];
    
    bottomL                =[[UILabel alloc] init];
    bottomL.text           =@"学习过程中,您可通过个人设置进行修改";
    bottomL.textColor      =LSColor(114, 113, 114, 1);
    bottomL.font           =[UIFont systemFontOfSize:10];
    bottomL.textAlignment  =NSTextAlignmentCenter;
    [scrollView addSubview:bottomL];
    
    [self resetFrame];
}

-(void)resetFrame{
    NSInteger rowNum =0;
    for (NSArray *array in allDataArray) {
        if (array.count>4) {
            if (array.count%4>0) {
                rowNum =array.count/4+1+rowNum;
            }else{
                rowNum =array.count/4+rowNum;
            }
        }else{
            rowNum =1+rowNum;
        }
    }
    myCollectionView.frame =CGRectMake(20,myCollectionView.frame.origin.y, LSMainScreenW-40,30*2+30+35*rowNum+20);
    saveBtn.frame =CGRectMake(35, CGRectGetMaxY(myCollectionView.frame)+ 30, LSMainScreenW-70, 35*LSScale);
    bottomL.frame =CGRectMake(35, CGRectGetMaxY(saveBtn.frame)+10, LSMainScreenW-70, 20*LSScale);
    [scrollView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(bottomL.frame)+65)];
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
        cell.label.text =self.model.prvnName;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    saveBtn.userInteractionEnabled        =YES;
    saveBtn.layer.backgroundColor         =LSNavColor.CGColor;

    self.model    =allDataArray[indexPath.section][indexPath.row];
    [self.dataDict setObject:self.model.id_ forKey:@"branchid"];
    [self.saveDict setObject:self.model.prvnName forKey:@"分校"];
    LsLog(@"==========================%@",self.dataDict);
}

-(void)settingRequest{
    [[LsAFNetWorkTool shareManger] LSPOST:@"updateallsetting.html" parameters:self.dataDict success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self settingSuccess];
        [LSUser_Default setObject:self.dataDict[@"scatgid"] forKey:@"scatgid"];
        [LSUser_Default setObject:self.dataDict[@"branchid"] forKey:@"branchid"];
        [LSUser_Default setObject:self.dataDict[@"catgid"] forKey:@"catgid"];
        [LSUser_Default setObject:self.saveDict forKey:@"配置"];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
    }];
}

-(void)settingSuccess{
    [LSUser_Default setObject:@"yes" forKey:@"didConfig"];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    LsAppDelegate *appdele=(LsAppDelegate*)LSApplicationDelegate;
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
}

-(LsBranchConfigureModel *)model{
    if (!_model) {
        _model  =[[LsBranchConfigureModel alloc] init];
    }
    return _model;
}


@end
