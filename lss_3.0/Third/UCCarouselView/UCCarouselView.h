//
//  UCCarouselView.h
//  UCCarouselView
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCCarouselView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    dataArray:(NSArray *)dataArray
           didSelectItemBlock:(void (^)(NSInteger didSelectItem))block;

- (instancetype)initWithFrame:(CGRect)frame
                    dataArray:(NSArray *)dataArray
                 timeInterval:(CGFloat)timeInterval
           didSelectItemBlock:(void (^)(NSInteger didSelectItem))block;

@end
