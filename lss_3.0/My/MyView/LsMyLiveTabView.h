//
//  LsMyLiveTabView.h
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myLiveTabDelegate <NSObject>

- (void)didClickMyLiveTabViewIndex:(NSInteger)index;

@end

@interface LsMyLiveTabView : UIView

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, weak)  id<myLiveTabDelegate> delegate;

-(void)switchMyLiveTab:(NSInteger)index;

@end
