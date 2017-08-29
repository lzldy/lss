//
//  LsChooseView.h
//  lss
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsButton.h"

@protocol chooseViewDelegate <NSObject>

- (void)chooseBtn:(LsButton*)button;

@end

@interface LsChooseView : UIView

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, weak) id<chooseViewDelegate> delegate;

@end
