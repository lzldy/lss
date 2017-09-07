//
//  LsTestChooseView.h
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol rightChooseViewDelegate <NSObject>

- (void)rightChooseBtn:(LsButton*)button;

@end

@interface LsTestChooseView : UIView

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, weak) id<rightChooseViewDelegate> delegate;

@end
