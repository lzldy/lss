//
//  LsFindViewController.m
//  lss
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsFindViewController.h"
#import "LsDataViewController.h"
#import "LsActivityViewController.h"
#import "LsOneToOneViewController.h" 
#import "LsTribeViewController.h"

@interface LsFindViewController ()<UIScrollViewDelegate>
{
    UIButton  *noOpenedBtn;
    UIView    *otherView;
}
@property (nonatomic,strong) UIScrollView *scrView;

@end

@implementation LsFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle     =@"发现";
    [superView addSubview:self.scrView];
    [self loadBaseUI];

}

-(void)loadBaseUI{
    UIView  *tribeView         =[[UIView alloc] initWithFrame:CGRectMake(0, 10*LSScale, LSMainScreenW, 40*LSScale)];
    tribeView.backgroundColor  =[UIColor whiteColor];
    
    UILabel *tribeL            =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 5*LSScale, 80*LSScale, 30*LSScale)];
    tribeL.text                =@"部落";
    tribeL.textColor           =LSNavColor;
    tribeL.textAlignment       =NSTextAlignmentLeft;
    
    UIImage      *tribeImage   =[UIImage imageNamed:@"more_btn"];
    UIButton  *tribeBtn        =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-5*LSScale-30*LSScale,5*LSScale, 30*LSScale, 30*LSScale)];
    [tribeBtn setImage:tribeImage forState:0];
    [tribeBtn addTarget:self action:@selector(clickTribeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [tribeView addSubview:tribeL];
    [tribeView addSubview:tribeBtn];
    [self.scrView addSubview:tribeView];
    
    //产品
    UILabel *productL       =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(tribeView.frame)+5*LSScale, 120*LSScale, 30*LSScale)];
    productL.textAlignment  =NSTextAlignmentLeft;
    productL.text           =@"良师产品";
    [self.scrView addSubview:productL];
    
    UIView  *productView    =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(productL.frame)+5*LSScale, LSMainScreenW, 80*LSScale)];
    productView.backgroundColor  =[UIColor whiteColor];
    [self.scrView addSubview:productView];
    
    LsButton  *fudao        =[[LsButton alloc] initWithFrame:CGRectMake(0, 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *fudaoImage   =[UIImage imageNamed:@"fd"];
    [fudao  setImage:fudaoImage forState:0];
    fudao.tag =0;
    [fudao addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [productView addSubview:fudao];
    
    UIView    *lineOne      =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fudao.frame), 0, 0.5*LSScale, 80*LSScale)];
    lineOne.backgroundColor =LSLineColor;
    [productView addSubview:lineOne];
    
    LsButton  *zhentiBtn        =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineOne.frame), 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *zhentiImage   =[UIImage imageNamed:@"jc"];
    [zhentiBtn  setImage:zhentiImage forState:0];
    zhentiBtn.tag =1;
    [zhentiBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [productView addSubview:zhentiBtn];

    UIView    *lineTwo      =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zhentiBtn.frame), 0, 0.5*LSScale, 80*LSScale)];
    lineTwo.backgroundColor =LSLineColor;
    [productView addSubview:lineTwo];
    
    //服务
    UILabel *serviceL       =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(productView.frame)+5*LSScale, 120*LSScale, 30*LSScale)];
    serviceL.textAlignment  =NSTextAlignmentLeft;
    serviceL.text           =@"良师服务";
    [self.scrView addSubview:serviceL];
    
    UIView  *serviceView         =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(serviceL.frame)+5*LSScale, LSMainScreenW, 80*LSScale)];
    serviceView.backgroundColor  =[UIColor whiteColor];
    [self.scrView addSubview:serviceView];

    LsButton  *zixunBtn          =[[LsButton alloc] initWithFrame:CGRectMake(0, 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *zixunImage        =[UIImage imageNamed:@"gg"];
    [zixunBtn  setImage:zixunImage forState:0];
    zixunBtn.tag =2;
    [zixunBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:zixunBtn];
    
    UIView    *serviceLineOne      =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zixunBtn.frame), 0, 0.5*LSScale, 80*LSScale)];
    serviceLineOne.backgroundColor =LSLineColor;
    [serviceView addSubview:serviceLineOne];
    
    LsButton  *cepingBtn        =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(serviceLineOne.frame), 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *cipingImage   =[UIImage imageNamed:@"yuy_kt"];
    [cepingBtn  setImage:cipingImage forState:0];
    cepingBtn.tag =3;
    [cepingBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:cepingBtn];
    
    UIView    *serviceLineTwo      =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cepingBtn.frame), 0, 0.5*LSScale, 80*LSScale)];
    serviceLineTwo.backgroundColor =LSLineColor;
    [serviceView addSubview:serviceLineTwo];
    
    LsButton  *huodongBtn        =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(serviceLineTwo.frame), 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *huodongBtnImage   =[UIImage imageNamed:@"cs"];
    [huodongBtn  setImage:huodongBtnImage forState:0];
    huodongBtn.tag =4;
    [huodongBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:huodongBtn];
    
    //其他
    UILabel *otherL       =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(serviceView.frame)+5*LSScale, 120*LSScale, 30*LSScale)];
    otherL.textAlignment  =NSTextAlignmentLeft;
    otherL.text           =@"其他";
    [self.scrView addSubview:otherL];
    
    otherView         =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(otherL.frame)+5*LSScale, LSMainScreenW, 80*LSScale)];
    otherView.backgroundColor  =[UIColor whiteColor];
    [self.scrView addSubview:otherView];

    LsButton  *yaoqingBtn        =[[LsButton alloc] initWithFrame:CGRectMake(0, 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *yaoqingImage   =[UIImage imageNamed:@"hy"];
    [yaoqingBtn  setImage:yaoqingImage forState:0];
    yaoqingBtn.tag =5;
    [yaoqingBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [otherView addSubview:yaoqingBtn];
    
    UIView    *otherLineOne      =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yaoqingBtn.frame), 0, 0.5*LSScale, 80*LSScale)];
    otherLineOne.backgroundColor =LSLineColor;
    [otherView addSubview:otherLineOne];
    
    LsButton  *zhuxueBtn        =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(otherLineOne.frame), 0, (LSMainScreenW-1*LSScale)/3, 80*LSScale)];
    UIImage   *zhuxueImage   =[UIImage imageNamed:@"zhuxue"];
    [zhuxueBtn  setImage:zhuxueImage forState:0];
    zhuxueBtn.tag =6;
    [zhuxueBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [otherView addSubview:zhuxueBtn];
    
    UIView    *otherlineTwo      =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zhuxueBtn.frame), 0, 0.5*LSScale, 80*LSScale)];
    otherlineTwo.backgroundColor =LSLineColor;
    [otherView addSubview:otherlineTwo];

    
    noOpenedBtn                =[[UIButton alloc] initWithFrame:CGRectMake(90*LSScale, CGRectGetMaxY(otherView.frame)+55*LSScale, LSMainScreenW-90*LSScale*2, 30*LSScale)];
    noOpenedBtn.backgroundColor =LSColor(145, 146, 147, 1);
    [noOpenedBtn setTitle:@"该栏目暂未开通" forState:0];
    noOpenedBtn.titleLabel.font   =[UIFont systemFontOfSize:13.5*LSScale];
    [noOpenedBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.scrView addSubview:noOpenedBtn];
    [self hiddenNoOpendBtn];
}


-(void)clickTribeBtn{
    LsLog(@"----------click部落----------");
    LsTribeViewController *vc =[[LsTribeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showNoOpendBtn{
    noOpenedBtn.hidden =NO;
    [self.scrView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(noOpenedBtn.frame)+40*LSScale+49*LSScale)];
    [self.scrView setContentOffset:CGPointMake(0,80*LSScale) animated:YES];
}

-(void)hiddenNoOpendBtn{
    noOpenedBtn.hidden =YES;
    [self.scrView setContentSize:CGSizeMake(LSMainScreenW, CGRectGetMaxY(otherView.frame)+40*LSScale+49*LSScale)];
    [self.scrView setContentOffset:CGPointMake(0,0) animated:YES];
}

-(void)clickBtn:(UIButton *)button{
//    [self hiddenNoOpendBtn];
    switch (button.tag) {
        case 0:
        {
            LsLog(@"-------------1对1辅导------------");
            LsOneToOneViewController *vc =[[LsOneToOneViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 1:
        {
            LsLog(@"-------------真题教参------------");
            [LsMethod alertMessage:@"该栏目暂未开通,敬请期待" WithTime:1.5];
//            [self showNoOpendBtn];
        }
            break;
        case 2:
        {
            LsLog(@"-------------公告咨询------------");
            LsDataViewController *vc =[[LsDataViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            LsLog(@"-------------预约测评------------");
//            [self showNoOpendBtn];
            [LsMethod alertMessage:@"该栏目暂未开通,敬请期待" WithTime:1.5];

        }
            break;
        case 4:
        {
            LsLog(@"-------------分校活动------------");
            LsActivityViewController *vc =[[LsActivityViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 5:
        {
            LsLog(@"-------------邀请好友------------");
//            [self showNoOpendBtn];
            [LsMethod alertMessage:@"该栏目暂未开通,敬请期待" WithTime:1.5];
        }
            break;
        case 6:
        {
            LsLog(@"-------------良师助学------------");
//            [self showNoOpendBtn];
            [LsMethod alertMessage:@"该栏目暂未开通,敬请期待" WithTime:1.5];
        }
            break;
        default:
            break;
    }
}

-(UIScrollView *)scrView{
    if (!_scrView) {
        _scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame),LSMainScreenW, LSMainScreenH-CGRectGetMaxY(self.navView.frame))];
        _scrView.showsHorizontalScrollIndicator   =NO;
        _scrView.showsVerticalScrollIndicator     =NO;
        _scrView.delegate                         =self;
        _scrView.backgroundColor                  =LSColor(243, 244, 245, 1);
    }
    return _scrView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
