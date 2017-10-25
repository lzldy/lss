//
//  LsPracticeModel.m
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPracticeModel.h"

@implementation LsPracticeListModel



@end

@implementation LsPracticeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"practiceLists"          :@"practiceList",
             @"practiceDataArray"      :@"data.list"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"practiceLists"        : [LsPracticeListModel class],
             @"practiceDataArray"    : [LsPracticeListModel class]};
}

@end
