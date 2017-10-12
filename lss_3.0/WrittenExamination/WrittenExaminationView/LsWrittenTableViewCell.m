//
//  LsWrittenTableViewCell.m
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWrittenTableViewCell.h"

@implementation LsWrittenTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor whiteColor];
        
     
        
        UIView * line                 =[[UIView alloc] initWithFrame:CGRectMake(0, 55*LSScale-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
        line.backgroundColor =LSLineColor;
        [self addSubview:line];
    }
    return self;
}


@end
