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
        self.backgroundColor  =[UIColor whiteColor];
        [self addSubview:line];
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray=dataArray;
    
    for (int i=0; i<dataArray.count; i++) {
        LsButton *view =[[LsButton alloc] initWithFrame:CGRectMake(space+i*(self.frame.size.width-2*space)/dataArray.count, 0,(self.frame.size.width-2*space)/dataArray.count, self.frame.size.height)];
        [self addSubview:view];
        
        NSString *imageName =[dataArray[i] objectForKey:@"imageName"];
        NSString *title     =[dataArray[i] objectForKey:@"title"];
        UIColor  *col       =[dataArray[i] objectForKey:@"color"];
        UIImage  *image     =[UIImage imageNamed:imageName];
        
        
        view.lsImageView.frame=CGRectMake(view.frame.size.width/2-image.size.width/2, 20, image.size.width, image.size.height);
        view.lsImageView.image=image;
        view.lsLabel.frame    =CGRectMake(0, CGRectGetMaxY(view.lsImageView.frame)+2, view.frame.size.width,20);
        view.lsLabel.text            =title;
        view.lsLabel.textColor       =col;
        view.lsLabel.textAlignment   =NSTextAlignmentCenter;
        view.lsLabel.font            =[UIFont systemFontOfSize:12];
        
        view.tag              =i;
        [view addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    }
}

-(void)didClickBtn:(UIButton*)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickHeaderViewIndex:)]) {
        [self.delegate didClickHeaderViewIndex:button.tag];
    }
}


@end
