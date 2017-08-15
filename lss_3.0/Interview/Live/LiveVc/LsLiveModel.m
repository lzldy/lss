//
//  LsLiveModel.m
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveModel.h"

@implementation LsTeacherModel



@end

@implementation LsLiveModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"          : @"id",
             @"teacherArray" : @"teachers"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"teacherArray"    : [LsTeacherModel class]};
}

@end
