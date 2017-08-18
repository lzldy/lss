//
//  LsNavTabView.h
//  lsNavTabView
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lsNavTabViewDelegate <NSObject>

- (void)lsNavTabViewIndex:(NSInteger)index;

@end

@interface LsNavTabView : UIView
@property (nonatomic, weak)  id<lsNavTabViewDelegate> delegate;

-(void)tabIndex:(float)indexxx;

@end
