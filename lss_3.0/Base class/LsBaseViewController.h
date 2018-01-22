//
//  LsBaseViewController.h
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsNavView.h"

@interface LsBaseViewController : UIViewController
{
    UIView *superView;
}
@property (assign,nonatomic) BOOL         closeIQKeyBoard;

@property (nonatomic,strong) LsNavView    *navView;
@property (nonatomic,strong) UIImageView  *bgImageView;
@end
