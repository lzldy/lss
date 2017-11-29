//
//  LsMyLiveModel.m
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyLiveModel.h"

@implementation LsMyLiveOfTeachersModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"id_"          : @"id"};
//}
//
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"livingList"       : [LsLiveModel class],
//             @"todayLiveList"    : [LsLiveModel class]};
//}

@end


@implementation LsMyLiveModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dataList"  :@"data.list"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"teachers"    : [LsMyLiveOfTeachersModel class],
             @"dataList"    : [LsMyLiveModel           class]};
}

@end
