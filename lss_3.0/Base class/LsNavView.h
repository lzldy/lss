//
//  LsNavView.h
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LsNavView : UIView

@property (nonatomic, strong) UIButton *leftButton;//左按钮
@property (nonatomic, strong) UIButton *rightButton;//右按钮
@property (nonatomic, strong) NSString *navTitle;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *line;

@end
