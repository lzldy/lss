//
//  ActionSheetView.m
//  Policy
//
//  Created by 李子龙 on 16/10/12.
//  Copyright © 2016年 lzl. All rights reserved.
//

#import "ActionSheetView.h"

@implementation ActionSheetView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, LSMainScreenW, LSMainScreenH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        UIButton *btn1 =[[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height/2-0.25)];
        btn1.backgroundColor   =LSNavColor;
        btn1.tag               =10765;
        [btn1 addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"111" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:btn1];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(btn1.frame), frame.size.width, 0.5)];
        line.backgroundColor =LSLineColor;
        [self addSubview:line];
        
        UIButton *btn2 =[[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(line.frame), frame.size.width, frame.size.height/2-0.25)];
        btn2.backgroundColor   =LSNavColor;
        btn2.tag               =10766;
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"222" forState:UIControlStateNormal];
        [self addSubview:btn2];        
    }
    return self;
}

-(void)didClickBtn:(UIButton*)button{
    if (button.tag ==10765) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseBtn:)]) {
            [self.delegate chooseBtn:@"111"];
        }
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseBtn:)]) {
            [self.delegate chooseBtn:@"222"];
        }
    }
    [self removeFromSuperview];
}


@end
