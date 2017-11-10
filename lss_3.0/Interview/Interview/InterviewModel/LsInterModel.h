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
@property(nonatomic,strong) NSURL    *clickurl;
@property(nonatomic,strong) NSURL    *picurl;

@property(nonatomic,strong) NSArray<LsBannerModel*>  *bannerArray;

@end

@interface LsInterModel : NSObject

@property (nonatomic,strong) NSArray<LsLiveModel*>         *liveArray;
@property (nonatomic,strong) LsPracticeModel               *practiceModel;

@end
