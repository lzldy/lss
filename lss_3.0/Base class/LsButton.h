//
//  LsButton.h
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveModel.h"

@interface LsButton : UIButton

@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *videoID;
@property (nonatomic,strong) NSString *roomID;
@property (nonatomic,strong) NSArray  *livevideos;
@property (nonatomic,strong) NSString *livestatus;

@property (nonatomic,assign) int       num;

@property (nonatomic,strong) NSURL    *url;
@property (nonatomic,assign) BOOL     isPackage;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL     isEnroll;
@property (nonatomic,assign) BOOL     isEvaluate;

@property (nonatomic,strong) LsLiveModel *model;

@property (nonatomic,strong) UIImageView *lsImageView;
@property (nonatomic,strong) UILabel     *lsLabel;

@end
