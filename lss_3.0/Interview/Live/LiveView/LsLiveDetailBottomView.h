//
//  LsLiveDetailBottomView.h
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveDetailModel.h"

@protocol liveDetailBottomViewDelegate <NSObject>

@optional
- (void)didEnrollSuccess:(LsLiveDetailModel*)model;

@end

@interface LsLiveDetailBottomView : UIView

@property (nonatomic,strong)  LsLiveDetailModel *model;
@property (nonatomic,  weak)  id<liveDetailBottomViewDelegate> delegate;

@end
