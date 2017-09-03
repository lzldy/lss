//
//  LsCommentView.m
//  lss
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCommentView.h"

@interface LsCommentView ()
{
    
}
@end

@implementation LsCommentView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0,0, LSMainScreenW, LSMainScreenH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
    }
    return self;
}

@end
