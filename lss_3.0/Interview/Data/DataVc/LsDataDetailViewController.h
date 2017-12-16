//
//  LsDataDetailViewController.h
//  lss
//
//  Created by apple on 2017/10/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseViewController.h"

@interface LsDataDetailViewController : LsBaseViewController

@property (nonatomic,strong) NSString * title_;
@property (nonatomic,strong) NSString * code;

@property (nonatomic,assign) BOOL     isBanner;
@property (nonatomic,strong) NSURL    *bannerUrl;

@property (nonatomic,assign) BOOL     isDoExe;
@property (nonatomic,strong) NSURL    *doExeUrl;

@end
