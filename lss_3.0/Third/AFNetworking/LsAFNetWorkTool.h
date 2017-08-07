//
//  LsAFNetWorkTool.h
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface LsAFNetWorkTool : AFHTTPSessionManager

+(void)monitorNet;

+(instancetype _Nullable )shareManger;

- (nullable NSURLSessionDataTask *)LSGET:(NSString *_Nullable)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (nullable NSURLSessionDataTask *)LSPOST:(NSString *_Nullable)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
