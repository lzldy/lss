//
//  LsInterView.m
//  lss
//
//  Created by apple on 2017/8/10.
//  Copyright © 2017年 lss. All rights reserved.
//
#define space 10
#import "LsInterView.h"

@implementation LsInterView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        UIView  *line         =[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        line.backgroundColor  =LSLineColor;
        [self addSubview:line];
        

    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray=dataArray;
    
    for (int i=0; i<dataArray.count; i++) {
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(space+i*(self.frame.size.width-2*space)/dataArray.count, 0,(self.frame.size.width-2*space)/dataArray.count, self.frame.size.height)];
        [self addSubview:view];
        
        NSString *imageName =[dataArray[i] objectForKey:@"imageName"];
        NSString *title     =[dataArray[i] objectForKey:@"title"];
        UIImage  *image     =[UIImage imageNamed:imageName];
        
        UIButton *button    =[[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width/2-image.size.width/2, 8, image.size.width, image.size.height)];
        [button setImage:image forState:UIControlStateNormal];
        button.tag          =i;
        [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UILabel  *label       =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+2, view.frame.size.width,20)];
        label.text            =title;
        label.textColor       =[UIColor darkTextColor];
        label.textAlignment   =NSTextAlignmentCenter;
        label.font            =[UIFont systemFontOfSize:14];
        [view addSubview:label];
        
    }
}

-(void)didClickBtn:(UIButton*)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickHeaderViewIndex:)]) {
        [self.delegate didClickHeaderViewIndex:button.tag];
    }
}


@end
