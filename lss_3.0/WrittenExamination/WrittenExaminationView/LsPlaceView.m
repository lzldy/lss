//
//  LsPlaceView.m
//  lss
//
//  Created by apple on 2017/12/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPlaceView.h"

@implementation LsPlaceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  =LSColor(243, 244, 245, 1);
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray   =dataArray;
    float  space =10*LSScale;
    for (int i=0; i<dataArray.count; i++) {
        
        LsPlaceModel *model  =dataArray[i];
        
        float  btn_w = (LSMainScreenW -6*space)/5;
        float  btn_h = 30*LSScale;
        float  btn_x = space+(btn_w+space)*(i%5);
        float  btn_y = (i/5)*30*LSScale +5*LSScale*((i/5)+1);
        UIButton *btn  =[[UIButton alloc]  initWithFrame:CGRectMake(btn_x, btn_y, btn_w, btn_h)];
        btn.backgroundColor  =[UIColor redColor];
        [btn setTitle:model.name forState:0];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag         =i;
        [self addSubview:btn];
        
        self.frame  =CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(btn.frame)+5*LSScale);

    }
}

-(void)clickBtn:(UIButton *)btn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickBtnIndex:)]) {
        [self.delegate didClickBtnIndex:btn.tag];
    }
}
    
@end
