//
//  LsConfigureModel.h
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseModel.h"

//项目
@interface LsCatgConfigureModel : NSObject

@property (nonatomic,strong)     NSString        *id_;
@property (nonatomic,strong)     NSString        *name;
@property (nonatomic,strong)     NSString        *code;
@property (nonatomic,strong)     NSString        *level;
@property (nonatomic,strong)     NSMutableArray  *levels;//学段


@end

//学段
@interface LsLevelConfigureModel : NSObject

@property (nonatomic,strong)     NSString        *name;
@property (nonatomic,strong)     NSString        *code;
@property (nonatomic,strong)     NSString        *level;
@property (nonatomic,strong)     NSMutableArray  *subjects;//科目

@end

//科目
@interface LsSubjectConfigureModel : NSObject

@property (nonatomic,strong)     NSString        *id_;
@property (nonatomic,strong)     NSString        *name;
@property (nonatomic,strong)     NSString        *code;
@property (nonatomic,strong)     NSString        *level;

@end

//分校
@interface LsBranchConfigureModel : NSObject

@property (nonatomic,strong)     NSString        *id_;
@property (nonatomic,strong)     NSString        *prvnName;
@property (nonatomic,strong)     NSString        *status;

@end

@interface LsConfigureModel : LsBaseModel

@property (nonatomic,strong) NSMutableArray   *catgs;       //项目
@property (nonatomic,strong) NSArray          *levels;      //学段
@property (nonatomic,strong) NSArray          *branchs;     //分校

@end
