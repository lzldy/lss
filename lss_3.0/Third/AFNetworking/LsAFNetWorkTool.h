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

@property (nonatomic,strong) LsAFNetWorkTool *manager;

+(void)monitorNet;

+(instancetype)shareManger;
-(void)get;
@end
