//
//  LsInterViewTableViewCell.m
//  lss
//
//  Created by apple on 2017/8/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsInterViewTableViewCell.h"

@implementation LsInterViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  =[UIColor clearColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
