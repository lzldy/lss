//
//  LsActivityModel.m
//  lss
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsActivityModel.h"

@implementation LsActivityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"          : @"id",
             @"dataArray"    : @"data.list"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataArray"    : [LsActivityModel class]};
}

@end
