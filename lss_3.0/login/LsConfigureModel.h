//
//  LsConfigureModel.h
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseModel.h"


@interface LsBaseConfigureModel : NSObject

@property (nonatomic,strong)     NSString *id_;
@property (nonatomic,strong)     NSString *name;
@property (nonatomic,strong)     NSString *code;
@property (nonatomic,strong)     NSString *level;
@property (nonatomic,strong)     NSMutableArray  *subjectArray;

@end

@interface LsConfigureModel : LsBaseModel

@property (nonatomic,strong) NSArray          *levels;      //学段
@property (nonatomic,strong) NSArray          *catgs;       //项目
@property (nonatomic,strong) NSArray          *branchs;     //分校
@property (nonatomic,strong) NSMutableArray   *allSubject;  //all科目

@end
