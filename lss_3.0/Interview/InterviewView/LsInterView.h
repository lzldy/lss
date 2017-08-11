//
//  LsInterView.h
//  lss
//
//  Created by apple on 2017/8/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol headerViewDelegate <NSObject>

- (void)didClickHeaderViewIndex:(NSInteger)index;

@end

@interface LsInterView : UIView

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, weak)  id<headerViewDelegate> delegate;

@end
