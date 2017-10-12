//
//  LsDataModel.m
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsDataModel.h"
@implementation LsDataDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"       : @"id"};
}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"liveArray"    : [LsLiveModel   class]};
//}
@end

@implementation LsDataModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dataArray"       : @"data"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataArray"    : [LsDataDetailModel   class]};
}

@end
