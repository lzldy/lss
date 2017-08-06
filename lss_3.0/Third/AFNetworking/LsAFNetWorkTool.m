//
//  LsAFNetWorkTool.m
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsAFNetWorkTool.h"

@implementation LsAFNetWorkTool

+(instancetype)shareManger{
    static LsAFNetWorkTool *mageer =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mageer = [[LsAFNetWorkTool alloc] init];
        mageer.requestSerializer.timeoutInterval=60;
        mageer.securityPolicy =[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return mageer;
}

-(LsAFNetWorkTool *)manager{
    if (!_manager) {
        _manager =[LsAFNetWorkTool shareManger];
    }
    return _manager;
}

+(void)monitorNet{
    
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        if (status<1) {
            [LsMethod alertMessage:@"请检查您的网络设置" WithTime:2];
        }else if (status==1){
            [LsMethod alertMessage:@"当前为4G网络" WithTime:2];
        }else{
            [LsMethod alertMessage:@"当前为WiFi网络" WithTime:2];
        }
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                LsLog(@"网络状态未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                LsLog(@"没有网络");
                break;
            case  AFNetworkReachabilityStatusReachableViaWWAN:
                LsLog(@"3G|4G蜂窝移动网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                LsLog(@"WIFI网络");
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}
@end
