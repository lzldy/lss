//
//  LsMyVideoModel.m
//  lss
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyVideoModel.h"

@implementation LsMyVideoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list"   : @"data.list"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list"       : [LsMyVideoModel class]};
}

@end
