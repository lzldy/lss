//
//  LsMessageModel.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMessageModel.h"

@implementation LsMessageModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"          : @"id",
             @"dataArray"   : @"data.list"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataArray"       : [LsMessageModel class]};
}

@end
