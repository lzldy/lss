//
//  LsMyLiveModel.h
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LsMyLiveModel.h"
#import "LsLiveModel.h"

@interface LsTodayLiveModel : NSObject

@property (nonatomic,strong)  NSArray *livingList;
@property (nonatomic,strong)  NSArray *todayLiveList;

@end

@interface LsMyLiveModel : NSObject

@property (nonatomic,strong)  LsTodayLiveModel *todayLive;
@property (nonatomic,strong)  NSArray          *playBack;
@property (nonatomic,strong)  NSArray          *notBegin;

@end
