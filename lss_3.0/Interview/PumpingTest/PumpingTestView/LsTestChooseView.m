//
//  LsTestChooseView.m
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsTestChooseView.h"

@implementation LsTestChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0,0, LSMainScreenW, LSMainScreenH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    }
    return self;
}


-(void)setDataArray:(NSArray *)dataArray{
//    @"title":@"录制视频",@"image":@"luzhi"
    _dataArray =dataArray;
    UIView  *baseView =[[UIView alloc] initWithFrame:CGRectMake(LSMainScreenW-100*LSScale, 64, 90*LSScale, 35*LSScale)];
    baseView.backgroundColor  =[UIColor whiteColor];
    [self addSubview:baseView];
    
    for (int i=0; i<dataArray.count; i++) {
        NSDictionary *dict       =dataArray[i];
        UIImage      *image      =[UIImage imageNamed:[dict objectForKey:@"image"]];
        NSString     *title      =[dict objectForKey:@"title"];
        LsButton     *button     =[[LsButton alloc] initWithFrame:CGRectMake(0, 35*LSScale*i, baseView.frame.size.width, 35*LSScale)];
        
        button.lsImageView.frame =CGRectMake(10*LSScale, 35*LSScale/2-image.size.height/2, image.size.width, image.size.height);
        button.lsImageView.image =image;
        button.lsLabel.frame     =CGRectMake(CGRectGetMaxX(button.lsImageView.frame), 0, button.frame.size.width-CGRectGetMaxX(button.lsImageView.frame),button.frame.size.height);
        button.lsLabel.text      =title;
        button.lsLabel.font      =[UIFont systemFontOfSize:12*LSScale];
        button.lsLabel.textAlignment =NSTextAlignmentCenter;
        UIView       *line       =[[UIView alloc]  initWithFrame:CGRectMake(0, 35*LSScale*(i+1)-0.5*LSScale, baseView.frame.size.width, 0.5*LSScale)];
        line.backgroundColor     =LSLineColor;
        button.tag               =i;
        [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:button];
        [baseView addSubview:line];
        baseView.frame  =CGRectMake(baseView.frame.origin.x, baseView.frame.origin.y, baseView.frame.size.width, CGRectGetMaxY(line.frame));
        
    }
}

-(void)didClickBtn:(LsButton*)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightChooseBtn:)]) {
        [self.delegate rightChooseBtn:btn];
    }
}

@end
