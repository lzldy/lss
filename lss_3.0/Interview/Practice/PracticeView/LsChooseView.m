//
//  LsChooseView.m
//  lss
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsChooseView.h"

@interface LsChooseView ()
{
    NSMutableArray *viewArray;
}
@end

@implementation LsChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0,0, LSMainScreenW, LSMainScreenH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray =dataArray;
    [self initView];
}

-(void)initView{
  
    UIView   *baseView  =[[UIView alloc] initWithFrame:CGRectMake(0, 64,LSMainScreenW,70*LSScale)];
    baseView.backgroundColor  =[UIColor whiteColor];
    
    UILabel *label      =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 10*LSScale, baseView.frame.size.width-30*LSScale, 20*LSScale)];
    label.text          =@"我想看的视频类型";
    label.textColor     =[UIColor darkTextColor];
    label.font          =[UIFont systemFontOfSize:13*LSScale];
    [baseView addSubview:label];
    [self addSubview:baseView];
    
    viewArray           =[NSMutableArray array];
    float   space1  =15*LSScale;
//    float   space2  =30*LSScale;
    float   btnW    =(baseView.frame.size.width-2*space1-(_dataArray.count-1)*space1)/_dataArray.count;
    for (int i=0; i<_dataArray.count; i++) {
        NSString   *btnTitle=[_dataArray[i] objectForKey:@"title"];
        NSString   *typeID  =[_dataArray[i] objectForKey:@"ID"];

        LsButton *button    =[[LsButton alloc] initWithFrame:CGRectMake(space1+i*(btnW+space1),CGRectGetMaxY(label.frame)+10*LSScale,btnW, 20*LSScale)];
        button.videoID      =typeID;
        button.tag          =i;
        [button setTitle:btnTitle forState:0];
        button.titleLabel.font  =[UIFont systemFontOfSize:13*LSScale];
        [button setTitleColor:[UIColor darkTextColor] forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.cornerRadius  =5;
        button.layer.borderWidth   =0.5*LSScale;
        button.layer.borderColor   =LSLineColor.CGColor;
        button.layer.backgroundColor =[UIColor whiteColor].CGColor;
        [button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:button];
        if (i==0) {
            button.selected=YES;
            button.layer.backgroundColor =LSNavColor.CGColor;
            button.layer.borderWidth   =0;
            button.layer.borderColor   =[UIColor clearColor].CGColor;
        }
        [viewArray addObject:button];
    }
}

-(void)didClickBtn:(LsButton*)button{
    for (int i=0; i<viewArray.count; i++) {
        LsButton *btn      =viewArray[i];
        if (button.tag==i) {
            btn.selected   =YES;
            btn.layer.backgroundColor =LSNavColor.CGColor;
            btn.layer.borderWidth   =0;
            btn.layer.borderColor   =[UIColor clearColor].CGColor;

        }else{
            btn.selected   =NO;
            btn.layer.backgroundColor =[UIColor whiteColor].CGColor;
            btn.layer.borderWidth   =1;
            btn.layer.borderColor   =LSLineColor.CGColor;

        }
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseBtn:)]) {
        [self.delegate chooseBtn:button];
    }
}

@end
