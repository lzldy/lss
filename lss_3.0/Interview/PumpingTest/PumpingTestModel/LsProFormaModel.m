//
//  LsProFormaModel.m
//  lss
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsProFormaModel.h"

@implementation LsProFormaModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"imageArray"       : @"data.files",
             @"imageUrl"         : @"url",
             @"name"             : @"data.name"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"imageArray"    : [LsProFormaModel   class]};
}

@end
