//
//  LsInterModel.h
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LsLiveModel.h"
#import "LsPracticeModel.h"

@interface LsBannerModel : NSObject

@property(nonatomic,strong) NSString *id_;
@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSURL    *url;

@end

@interface LsInterModel : NSObject

@property (nonatomic,strong) NSArray<LsLiveModel*>         *liveArray;
@property (nonatomic,strong) LsPracticeModel               *practiceModel;
@property (nonatomic,strong) NSArray                       *bannerArray;
@end
