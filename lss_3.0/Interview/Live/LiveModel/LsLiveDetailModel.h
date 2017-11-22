//
//  LsLiveDetailModel.h
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LsLiveModel.h"

@interface LsCourseArrangementModel : NSObject

@property (nonatomic,strong)  NSString  *endDate;
@property (nonatomic,strong)  NSString  *startDate;
@property (nonatomic,strong)  NSString  *endTime;
@property (nonatomic,strong)  NSString  *startTime;

@property (nonatomic,strong)  NSString  *testPaperTitle;
@property (nonatomic,strong)  NSURL     *testUrl;
@property (nonatomic,strong)  NSString  *title;
@property (nonatomic,strong)  NSString  *videoId;

@property (nonatomic,assign)  BOOL      mybuy;
@property (nonatomic,strong)  NSArray   *livevideos;

@property (nonatomic,strong)  NSString  *id_;
@property (nonatomic,strong)  NSString  *liveId;
@property (nonatomic,strong)  NSString  *recordVideoId;
@property (nonatomic,strong)  NSString  *stopTime;
@property (nonatomic,strong)  NSURL     *replayUrl;

@end

@interface LsLiveDetailModel : NSObject

@property (nonatomic,strong)  NSString *classHours;
@property (nonatomic,assign)  NSInteger personNum;
@property (nonatomic,strong)  NSString  *id_;
@property (nonatomic,strong)  NSString  *title;
@property (nonatomic,strong)  NSString  *liveId;
@property (nonatomic,strong)  NSString  *recordVideoId;

@property (nonatomic,strong)  NSString  *endDate;
@property (nonatomic,strong)  NSString  *startDate;
@property (nonatomic,strong)  NSString  *endTime;
@property (nonatomic,strong)  NSString  *startTime;

@property (nonatomic,strong)  NSString  *info;

@property (nonatomic,assign)  BOOL       isPackage;//套餐
@property (nonatomic,assign)  BOOL       enrollmentStatus;//正在报名
@property (nonatomic,assign)  BOOL       mybuy;//是否报名
@property (nonatomic,assign)  BOOL       isFree;//是否免费

@property (nonatomic,strong)  NSArray  *courseArrangement;
@property (nonatomic,strong)  LsCourseIntroductionModel *courseIntroduction;


@end
