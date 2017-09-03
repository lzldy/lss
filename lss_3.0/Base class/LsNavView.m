//
//  LsNavView.m
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsNavView.h"

@implementation LsNavView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0,0,LSMainScreenW,64);
        
        self.backgroundColor = LSNavColor;
        
        self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_leftButton setImage:[UIImage imageNamed:@"return_button"] forState:UIControlStateNormal];
        
        [self addSubview:_leftButton];
        
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(LSMainScreenW -54, 20, 44, 44)];
        _rightButton.titleLabel.font =[UIFont systemFontOfSize:17];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_rightButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LSMainScreenW/2-120*LSScale, 20, 240*LSScale, 44)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        
//        _line =[[UIView alloc] initWithFrame:CGRectMake(0, 64-0.5, LSMainScreenW, 0.5)];
//        _line.backgroundColor =LSColor(220, 220, 220, 1);
//        [self addSubview:_line];
    }
    return self;
}

-(void)setNavTitle:(NSString *)navTitle{
    if (![_navTitle isEqualToString:navTitle]) {
        if (_navTitle) {
            _navTitle = nil;
        }
        _navTitle = navTitle;
        _titleLabel.text = _navTitle;
    }
}

@end
