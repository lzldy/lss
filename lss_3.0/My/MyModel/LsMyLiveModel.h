//
//  LsMyLiveModel.h
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LsMyLiveModel.h"
#import "LsLiveModel.h"

@interface LsMyLiveOfTeachersModel : NSObject

@property (nonatomic,strong)  NSString   *name;
@property (nonatomic,strong)  NSString   *aliasName;
@property (nonatomic,strong)  NSURL      *idCardUrl;
@property (nonatomic,strong)  NSString   *desc;
@property (nonatomic,strong)  NSString   *info;
@property (nonatomic,strong)  NSString   *tid;
@property (nonatomic,strong)  NSString   *uid;

@end

@interface LsMyLiveModel : NSObject

@property (nonatomic,strong)  NSArray          *dataList;
@property (nonatomic,strong)  NSString         *ratenum;//评论人数
@property (nonatomic,strong)  NSString         *baseNum;
@property (nonatomic,strong)  NSString         *courseCode;
@property (nonatomic,strong)  NSString         *startDay;
@property (nonatomic,strong)  NSString         *endDay;
@property (nonatomic,strong)  NSString         *totalHour;
@property (nonatomic,assign)  BOOL              myrate;
@property (nonatomic,strong)  NSString         *livestatus;
@property (nonatomic,strong)  NSString         *regNum;
@property (nonatomic,strong)  NSString         *name;
@property (nonatomic,strong)  NSArray          *teachers;
@property (nonatomic,strong)  NSString         *crid;//业务ID



@end
