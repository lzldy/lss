//
//  LsTabBarViewController.m
//  lss
//
//  Created by apple on 2017/7/26.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsTabBarViewController.h"
#import "LsLiveBroadcastViewController.h"
#import "LsPracticeViewController.h"
#import "LsProFormaViewController.h"
#import "LsDynamicViewController.h"
#import "LsMyViewController.h"
#import "LsBaseNaViewController.h"

@interface LsTabBarViewController ()

@end

@implementation LsTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setTabBar];
}

- (void)setTabBar {
    // 去掉TabBar的阴影线
//    self.tabBar.backgroundColor = [UIColor whiteColor];
//    [self.tabBar setShadowImage:[[UIImage alloc] init]];
//    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    
    /**** 添加子控制器 ****/
    LsLiveBroadcastViewController *lbVc = [[LsLiveBroadcastViewController alloc] init];
    [self addVcToTabVcWithViewController:lbVc title:@"面试" image:@"ms_button_before" selectedImage:@"ms_button_after"];
    
    LsProFormaViewController      *pfVc = [[LsProFormaViewController alloc] init];
    [self addVcToTabVcWithViewController:pfVc title:@"笔试" image:@"bs_button_before" selectedImage:@"bs_button_after"];

    LsPracticeViewController      *prVc = [[LsPracticeViewController alloc] init];
    [self addVcToTabVcWithViewController:prVc title:@"发现" image:@"fx_button_before" selectedImage:@"fx_button_after"];

//    LsDynamicViewController       *dnVc = [[LsDynamicViewController alloc] init];
//    [self addVcToTabVcWithViewController:dnVc title:@"动态" image:@"hot_button" selectedImage:@"hot_button_click"];

    LsMyViewController            *myVc = [[LsMyViewController alloc] init];
    [self addVcToTabVcWithViewController:myVc title:@"我的" image:@"wd_button_before" selectedImage:@"wd_button_after"];
   
    [self setValue:self.lsTabBar forKeyPath:@"tabBar"];
    //选中颜色
//    self.lsTabBar.tintColor=[UIColor redColor];
    //设定Tabbar的颜色
    [[LsTabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [self setupItemTitleTextAttributes];

}

-(void)addVcToTabVcWithViewController:(LsBaseViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
   
    LsBaseNaViewController *lbNav = [[LsBaseNaViewController alloc] initWithRootViewController:vc];
    vc.title = title;
    if (image.length) {
        
//        if ([vc isKindOfClass:[LsPracticeViewController class]]) {
//            lbNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);//{top, left, bottom, right}
//        }
        lbNav.tabBarItem.title = title;
        lbNav.tabBarItem.image = [UIImage imageNamed:image];
        lbNav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self addChildViewController:lbNav];
}

- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor greenColor];
//    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] =LSNavColor;
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

//懒加载
-(LsTabBar *)lsTabBar{
    if (!_lsTabBar) {
        _lsTabBar =[[LsTabBar alloc] init];
    }
    return _lsTabBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
