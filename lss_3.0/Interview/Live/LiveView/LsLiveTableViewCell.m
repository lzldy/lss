//
//  LsLiveTableViewCell.m
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveTableViewCell.h"

@implementation LsLiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  =[UIColor whiteColor];
        UILabel  *titleL      =[[UILabel alloc] initWithFrame:CGRectMake(20, 12*LSScale, LSMainScreenW-40, 30*LSScale)];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
