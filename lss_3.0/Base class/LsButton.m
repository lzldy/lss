//
//  LsButton.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsButton.h"

@implementation LsButton

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.lsImageView  =[[UIImageView alloc] init];
        [self addSubview:self.lsImageView];
        
        self.lsLabel      =[[UILabel alloc] init];
        [self addSubview:self.lsLabel];
    }
    return self;
}

@end
