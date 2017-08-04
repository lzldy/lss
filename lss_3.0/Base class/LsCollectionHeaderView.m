//
//  LsCollectionHeaderView.m
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCollectionHeaderView.h"

@implementation LsCollectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        UILabel *label  =[[UILabel alloc] initWithFrame:frame];
        label.textColor =LSColor(102, 102, 102, 1);
        label.font      =[UIFont systemFontOfSize:15];
        [self addSubview:label];
        self.label      =label;
        self.backgroundColor   =[UIColor greenColor];
    }
    return self;
}

@end
