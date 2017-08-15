//
//  LsInterModel.m
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsInterModel.h"

@implementation LsBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"       : @"id",
             };
}

@end

@implementation LsInterModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"liveArray"       : @"data.live",
             @"practiceModel"   : @"data.practice",
             @"bannerArray"     : @"data.banner"
            };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"liveArray"    : [LsLiveModel   class],
             @"bannerArray"  : [LsBannerModel class]
             };
}

@end
