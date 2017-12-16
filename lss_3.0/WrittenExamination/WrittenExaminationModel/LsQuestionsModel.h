//
//  LsQuestionsModel.h
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsQuestionsDetailModel : NSObject


@property (nonatomic,strong)  NSString *ID;
@property (nonatomic,strong)  NSString *typeStr;
@property (nonatomic,strong)  NSURL    *doExeUrl;
@property (nonatomic,strong)  NSString *code;
@property (nonatomic,strong)  NSString *name;
@property (nonatomic,strong)  NSString *prvn;
@property (nonatomic,strong)  NSString *city;
@property (nonatomic,strong)  NSString *year;

@property (nonatomic,strong)  NSString *parsedQuestNum;//总提数
@property (nonatomic,strong)  NSString *maxCorrQuestNum;//最大正确题目数量
@property (nonatomic,strong)  NSString *exeNum;//我的练习次数
@property (nonatomic,strong)  NSString *totalExeNum;//所有人对这套题的练习次数
@property (nonatomic,strong)  NSString *lastExeTime;//最后一次练习时间

@end

@interface LsQuestionsModel : NSObject


@property (nonatomic,strong)  NSString *ID;
@property (nonatomic,strong)  NSString *catgid;
@property (nonatomic,strong)  NSString *catgName;
@property (nonatomic,strong)  NSString *scatgid;
@property (nonatomic,strong)  NSString *total;
@property (nonatomic,strong)  NSString *scatgName;
@property (nonatomic,strong)  NSArray  *list;

@property (nonatomic,strong)  NSArray  *dataArray;

@end
