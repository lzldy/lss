//
//  LsInterCellHeaderView.h
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol interCellHeaderViewDelegate <NSObject>

- (void)didClickHeaderViewRightBtnIndex:(NSInteger)index;

@end

@interface LsInterCellHeaderView : UIView
@property (nonatomic, weak)  id<interCellHeaderViewDelegate> delegate;

-(void)setLeftTitle:(NSString*)left AndRightTitle:(NSString*)right Index:(NSInteger)index;

@end
