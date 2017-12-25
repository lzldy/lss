//
//  LsMyHeaderView.m
//  lss
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyHeaderView.h"

@implementation LsMyHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius               =5*LSScale;
        UIImage   *image                      =LOADIMAGE(@"jrxyj_icon");
        
        self.headerIcon                       =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale, 10*LSScale, 60*LSScale, 60*LSScale)];
        self.headerIcon.layer.cornerRadius    =30*LSScale;
        self.headerIcon.layer.masksToBounds   =YES;
        [self addSubview:self.headerIcon];
        
        UIImageView    *imageView1            =[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-15*LSScale-image.size.width, CGRectGetMidY(self.headerIcon.frame)-image.size.height/2, image.size.width, image.size.height)];
        imageView1.image                      =image;
        [self addSubview:imageView1];
        
        UIView *line                          =[[UIView alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(self.headerIcon.frame)+10*LSScale, self.frame.size.width-20*LSScale, 0.5*LSScale)];
        line.backgroundColor                  =LSLineColor;
        [self addSubview:line];
        
        NSString  *labelStr                   =@"我的考试目标：";
        CGSize     size                       = [LsMethod sizeWithString:labelStr font:[UIFont systemFontOfSize:12*LSScale]];
        
        UILabel *label                        =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(line.frame), size.width, self.frame.size.height-CGRectGetMaxY(line.frame))];
        label.text                            =labelStr;
        label.textColor                       =[UIColor darkGrayColor];
        label.font                            =[UIFont systemFontOfSize:12*LSScale];
        [self addSubview:label];
        
        self.target                           =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame), self.frame.size.width-20*LSScale-label.frame.size.width, CGRectGetHeight(label.frame))];
        NSMutableDictionary *dict             =[LSUser_Default objectForKey:@"配置"];
        self.target.text                      =[NSString stringWithFormat:@"%@|%@|%@|%@",[dict objectForKey:@"项目"],[dict objectForKey:@"学段"],[dict objectForKey:@"科目"],[dict objectForKey:@"分校"]];
        self.target.textAlignment             =NSTextAlignmentLeft;
        self.target.font                      =[UIFont systemFontOfSize:12*LSScale];
        [self addSubview:self.target];
        
        UIImageView    *imageView2            =[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-15*LSScale-image.size.width, CGRectGetMidY(self.target.frame)-image.size.height/2, image.size.width, image.size.height)];
        imageView2.image                      =image;
        [self addSubview:imageView2];
        
        self.name                             =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale+CGRectGetMaxX(self.headerIcon.frame), CGRectGetMidY(self.headerIcon.frame)-20*LSScale, 80*LSScale, 20*LSScale)];
        self.name.textAlignment               = NSTextAlignmentLeft;
        self.name.font                        = [UIFont systemFontOfSize:14.5*LSScale];
        [self addSubview:self.name];
        
        self.autograph                        =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame), self.frame.size.width -CGRectGetMinX(self.name.frame)-20*LSScale, 30*LSScale)];
        self.autograph.numberOfLines          =0;
        self.autograph.font                   =[UIFont systemFontOfSize:12*LSScale];
        self.autograph.textAlignment          =NSTextAlignmentLeft;
        self.autograph.textColor              =[UIColor darkGrayColor];
        if ([LsSingleton sharedInstance].user.memo) {
            self.autograph.text               =[LsSingleton sharedInstance].user.memo;
        }else{
            self.autograph.text               =@"快点来介绍下自己吧";
        }
        [self addSubview:self.autograph];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigleTappedView:)];
        [singleTap setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

-(void)setUesr:(User *)uesr{
    _uesr  =uesr;
    [self.headerIcon sd_setImageWithURL:_uesr.face placeholderImage:LOADIMAGE(@"touxiang_icon")];
    
    if ([LsMethod haveValue:_uesr.nickName]) {
        self.name.text                   =_uesr.nickName;
    }else{
        self.name.text                   =@"姓名";
    }

    if ([LsMethod haveValue:_uesr.memo]) {
        self.autograph.text               =_uesr.memo;
    }else{
        self.autograph.text               =@"快点来介绍下自己吧";
    }
}

- (void)sigleTappedView:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    // 判断该点在不在区域内
    if (CGRectContainsPoint(CGRectMake(0,0, self.frame.size.width, CGRectGetMinX(self.autograph.frame)), point)){
        LsLog(@"-------------点击了上边---------------");
        if (self.delegate&&[self.delegate respondsToSelector:@selector(clickMyHeaderViewIndex:)]) {
            [self.delegate clickMyHeaderViewIndex:0];
        }
    }else{
        LsLog(@"-------------点击了下边---------------");
        if (self.delegate&&[self.delegate respondsToSelector:@selector(clickMyHeaderViewIndex:)]) {
            [self.delegate clickMyHeaderViewIndex:1];
        }
    }
}

@end
