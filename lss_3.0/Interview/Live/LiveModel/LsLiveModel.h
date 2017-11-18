//
//  LsLiveModel.h
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsTeacherModel : NSObject

@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherIcon;

@end

@interface LsCourseIntroductionModel : NSObject

@property (nonatomic,strong) NSURL    *introduceUrl;
@property (nonatomic,strong) NSString *introduce;

@end

@interface LsLiveModel : NSObject

@property (nonatomic,assign) NSInteger personNum;
@property (nonatomic,strong) NSString  *id_;
@property (nonatomic,strong) NSString  *code;
@property (nonatomic,strong) NSString  *endDate;
@property (nonatomic,strong) NSString  *startDate;
@property (nonatomic,strong) NSString  *title;
@property (nonatomic,strong) NSString  *endTime;
@property (nonatomic,strong) NSString  *startTime;
@property (nonatomic,strong) NSString  *livestatus;//-1 正在报名 0 直播中 1可回放

@property (nonatomic,strong) NSString  *videoId;

@property (nonatomic,assign) BOOL       isPackage;//套餐
@property (nonatomic,assign) BOOL       isRecommend;//推荐
//@property (nonatomic,assign) BOOL       enrollmentStatus;//正在报名
@property (nonatomic,assign) BOOL       isEvaluated;//已评价
@property (nonatomic,assign) BOOL       mybuy;

@property (nonatomic,strong) NSArray<LsTeacherModel*>  *teacherArray;
@property (nonatomic,strong) LsCourseIntroductionModel *courseIntroduction;
@property (nonatomic,strong) NSArray<LsLiveModel*>     *liveArray;

@end
