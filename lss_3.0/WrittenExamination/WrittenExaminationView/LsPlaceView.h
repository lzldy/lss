//
//  LsPlaceView.h
//  lss
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsPlaceModel.h"

@protocol placeViewDelegate <NSObject>

@optional

- (void)didClickBtnIndex:(NSInteger)index;

@end

@interface LsPlaceView : UIView

@property (nonatomic,strong)  NSArray *dataArray;
@property (nonatomic,  weak)  id<placeViewDelegate> delegate;

@end
