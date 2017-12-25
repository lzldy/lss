//
//  LsSingleton.m
//  lss
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsSingleton.h"

@implementation Setting

@end


@implementation User

@end

@implementation LsSingleton

+(LsSingleton *)sharedInstance{
    
    static dispatch_once_t  danli;
    static LsSingleton * SharedInstance;
    
    dispatch_once(&danli, ^{
        SharedInstance = [[LsSingleton alloc] init];
    });
    return SharedInstance;
}


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"user"          : @"data.user",
             @"setting"       : @"data.setting"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user"          : [User      class],
             @"setting"       : [Setting   class]
             };
}

@end
