//
//  LsLoginViewController.h
//  lss
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LsLoginViewController : LsBaseViewController

//@property (nonatomic,assign)   BOOL     isGetCodeVc;
@property (nonatomic,strong)   NSString *phoneNumber;

@property (nonatomic,assign)   BOOL     isLoginVc;
@property (nonatomic,assign)   BOOL     isRegisterVc;

@end
