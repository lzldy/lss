//
//  LsQuestionsModel.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsQuestionsModel.h"

@implementation LsQuestionsDetailModel

+ (NSDictionary *)LsQuestionsDetailModel {
    return @{@"ID"          : @"id",
             @"dataArray"   : @"data.papers"
             };
}
//
//+ (NSDictionary *)LsQuestionsDetailModel {
//    return @{@"dataArray"       : [LsQuestionsModel class]};
//}

@end


@implementation LsQuestionsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"          : @"id",
             @"dataArray"   : @"data.papers"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataArray"       : [LsQuestionsModel class],
             @"list"            : [LsQuestionsDetailModel class]};
}

@end
