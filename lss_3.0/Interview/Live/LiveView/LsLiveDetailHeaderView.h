//
//  LsLiveDetailHeaderView.h
//  lss
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveDetailModel.h"

@protocol liveDetailHeaderViewDelegate <NSObject>

@optional

- (void)didClickBtnIndex:(NSInteger)index;

@end

@interface LsLiveDetailHeaderView : UIView

@property (nonatomic,strong)  LsLiveDetailModel *model;
@property (nonatomic,  weak)  id<liveDetailHeaderViewDelegate> delegate;

@end
