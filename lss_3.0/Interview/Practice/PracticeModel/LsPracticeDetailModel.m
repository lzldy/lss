//
//  LsPracticeDetailModel.m
//  lss
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPracticeDetailModel.h"

@implementation LsPracticeTTCommentModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"ID":@"id",
              @"dataList":@"data.list"
              };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList" : [LsPracticeTTCommentModel class]
             };
}

@end

@implementation LsPracticeTSCommentModel


//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{ @"self":@"data"};
//}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{
//             @"self" : [LsPracticeDetailModel class]
//             };
//}

@end


@implementation LsPracticeDetailModel


//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{ @"self":@"data"};
//}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{
//             @"self" : [LsPracticeDetailModel class]
//             };
//}

@end
