//
//  LsPracticeDetailModel.m
//  lss
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPracticeDetailModel.h"

@implementation LsPracticeCommentModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"ID":@"id",
              @"dataList":@"data.list"
              };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"dataList" : [LsPracticeCommentModel class],
             @"replys"   : [LsPracticeCommentModel class]
             };
}

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
