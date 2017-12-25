//
//  LsPlaceModel.m
//  lss
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPlaceModel.h"

@implementation LsPlaceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"          : @"id",
             @"dataArray"   : @"data.regions"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataArray"       : [LsPlaceModel class]};
}

@end
