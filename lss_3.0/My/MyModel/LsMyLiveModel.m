//
//  LsMyLiveModel.m
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyLiveModel.h"

@implementation LsTodayLiveModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"          : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"livingList"       : [LsLiveModel class],
             @"todayLiveList"    : [LsLiveModel class]};
}

@end


@implementation LsMyLiveModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"          : @"id",
             @"notBegin"     : @"data.notBegin",
             @"playBack"     : @"data.playBack",
             @"todayLive"    : @"data.todayLive"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"notBegin"    : [LsLiveModel class],
             @"playBack"    : [LsLiveModel class]
             };
}

@end
