//
//  LsMyOrderModel.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyOrderModel.h"

@implementation LsMyOrderModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list"   : @"data.list"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list"       : [LsMyOrderModel class]};
}

@end
