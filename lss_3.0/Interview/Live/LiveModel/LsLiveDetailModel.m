//
//  LsLiveDetailModel.m
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailModel.h"

@implementation LsCourseArrangementModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"id_"          : @"id"};
//}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"teacherArray"    : [LsTeacherModel class],
//             @"liveArray"       : [LsLiveModel class]};
//}

@end

@implementation LsLiveDetailModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"          : @"id",
             @"self"         : @"data"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"courseArrangement"    : [LsCourseArrangementModel class]};
}
@end
