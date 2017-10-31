//
//  LsMyHeaderView.h
//  lss
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myHeaderViewDelegate <NSObject>

- (void)clickMyHeaderViewIndex:(NSInteger)index;

@end

@interface LsMyHeaderView : UIView

@property (nonatomic,strong)  UIImageView *  headerIcon;
@property (nonatomic,strong)  UILabel     *  autograph;
@property (nonatomic,strong)  UILabel     *  name;
@property (nonatomic,strong)  UILabel     *  target;

@property (nonatomic, weak)   id<myHeaderViewDelegate> delegate;

@end
