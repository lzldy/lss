//
//  LsInterCellHeaderView.m
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsInterCellHeaderView.h"

@interface LsInterCellHeaderView ()
{
    UIView  *baseView;
}
@property (nonatomic,strong) UILabel   *leftLabel;
@property (nonatomic,strong) UIButton  *rightBtn;

@end

@implementation LsInterCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor clearColor];
        baseView       =[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
//        UIView *leftView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.5, baseView.frame.size.height)];
//        leftView.backgroundColor =LSNavColor;
//        [baseView addSubview:leftView];
        
        self.leftLabel                      = [[UILabel alloc] init];
        self.leftLabel.numberOfLines        = 0;
        self.leftLabel.textColor            = [UIColor darkTextColor];
        self.leftLabel.font                 = [UIFont systemFontOfSize:16];
        [baseView addSubview:self.leftLabel];
        
        UIImage      *image        =[UIImage imageNamed:@"more_btn"];
        UIImageView  *imageView    =[[UIImageView alloc] initWithFrame:CGRectMake(baseView.frame.size.width-15-10, 12 ,9, 15)];
        imageView.image            =image;
        [baseView addSubview:imageView];
        
        self.rightBtn              =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)-50, 0, 50, baseView.frame.size.height)];
        self.rightBtn.backgroundColor =[UIColor clearColor];
        self.rightBtn.titleLabel.font =[UIFont systemFontOfSize:15.5];
        [self.rightBtn setTitleColor:LSNavColor forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:self.rightBtn];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height-0.5, LSMainScreenW, 0.5)];
        line.backgroundColor =LSLineColor;
        [baseView addSubview:line];

    }
    return self;
}

-(void)clickBtn:(UIButton*)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickHeaderViewRightBtnIndex:)]) {
        [self.delegate didClickHeaderViewRightBtnIndex:button.tag];
    }
}

-(void)setLeftTitle:(NSString*)left AndRightTitle:(NSString*)right  Index:(NSInteger)index{
   
    CGSize size           = [LsMethod sizeWithString:left font:self.leftLabel.font];
    self.leftLabel.frame  = CGRectMake(10, 0, size.width,baseView.frame.size.height);
    self.leftLabel.text   = left;
    [self.rightBtn setTitle:right forState:UIControlStateNormal];
    self.rightBtn.tag     =index;

}

@end
