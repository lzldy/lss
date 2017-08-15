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

@interface LsLiveModel : NSObject

@property (nonatomic,assign) NSInteger personNum;
@property (nonatomic,strong) NSString  *id_;
@property (nonatomic,strong) NSString  *endDate;
@property (nonatomic,strong) NSString  *startDate;
@property (nonatomic,strong) NSString  *title;
@property (nonatomic,strong) NSString  *endTime;
@property (nonatomic,strong) NSString  *startTime;
@property (nonatomic,strong) NSArray<LsTeacherModel*>  *teacherArray;

@end
