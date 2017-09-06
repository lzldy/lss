//
//  LsPlayBackViewController.h
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseViewController.h"
#import "LsLiveModel.h"

@interface LsPlayBackViewController : LsBaseViewController

@property (nonatomic,strong)  NSString    *navTitle;
@property (nonatomic,strong)  NSString    *ID;
@property (nonatomic,strong)  LsLiveModel *model;

@end
