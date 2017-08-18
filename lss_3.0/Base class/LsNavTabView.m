//
//  LsNavTabView.m
//  lsNavTabView
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsNavTabView.h"

@interface LsNavTabView ()

{
    CALayer  *myLayer;
    UIButton *btnOne;
    UIButton *btnTwo;
    NSInteger index;
    BOOL     isClickBtn;
}

@end

@implementation LsNavTabView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    =LSColor(208, 0, 40, 1);
        self.layer.cornerRadius =frame.size.height/2;
        index                   =8021;
        
        myLayer                 = [CALayer layer];
        myLayer.cornerRadius    =frame.size.height/2;
        [myLayer setFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        [myLayer setBackgroundColor:[UIColor whiteColor].CGColor];

        [self.layer addSublayer:myLayer];
        
        btnOne        =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        btnOne.backgroundColor  =[UIColor clearColor];
        btnOne.tag              =0;
        [btnOne setTitle:@"面试" forState:UIControlStateNormal];
        [btnOne  setTitleColor:LSNavColor forState:UIControlStateNormal];
        [btnOne addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnOne];
        
        btnTwo        =[[UIButton alloc] initWithFrame:CGRectMake( frame.size.width/2,0, frame.size.width/2, frame.size.height)];
        btnTwo.backgroundColor  =[UIColor clearColor];
        btnTwo.tag              =1;
        [btnTwo setTitle:@"笔试" forState:UIControlStateNormal];
        [btnTwo  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnTwo addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTwo];

    }
    return self;
}

-(void)clickBtn:(UIButton*)button{
    isClickBtn=YES;
    if (button.tag!=index) {
        if (button.tag==0) {
            [btnOne  setTitleColor:LSNavColor forState:UIControlStateNormal];
            [btnTwo  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            myLayer.position =CGPointMake(CGRectGetMidX(btnOne.frame), CGRectGetMidY(btnOne.frame));

        }else{
            [btnOne  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnTwo  setTitleColor:LSNavColor forState:UIControlStateNormal];
            myLayer.position =CGPointMake(CGRectGetMidX(btnTwo.frame), CGRectGetMidY(btnTwo.frame));

        }
        index    =button.tag;
//        myLayer.position =CGPointMake(CGRectGetMidX(button.frame), CGRectGetMidY(button.frame));
        //position  是中心点的位移
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(lsNavTabViewIndex:)]) {
            [self.delegate lsNavTabViewIndex:button.tag];
        }
    }
}

-(void)tabIndex:(float)indexxx{
        myLayer.position =CGPointMake(CGRectGetMidX(btnOne.frame)+CGRectGetWidth(self.frame)/2*indexxx, CGRectGetMidY(btnOne.frame));
        
        if (indexxx==1) {
            index    =1;
            [btnOne  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnTwo  setTitleColor:LSNavColor forState:UIControlStateNormal];
        }
        
        if (indexxx==0) {
            index  =0;
            [btnOne  setTitleColor:LSNavColor forState:UIControlStateNormal];
            [btnTwo  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
}


@end
