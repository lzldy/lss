//
//  LsDataTableViewCell.m
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsDataTableViewCell.h"

@interface LsDataTableViewCell ()
{
    UILabel     *titleL;
    UIImageView *imageView;
    UIImageView *iconView;
    UILabel     *nameL;
    UIImageView *timeView;
    UILabel     *timeL;
    UIImageView *perNumView;
    UILabel     *perNumL;
}
@end

@implementation LsDataTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor whiteColor];
        titleL                   =[[UILabel alloc] init];
        titleL.font              =[UIFont systemFontOfSize:15*LSScale];
        titleL.textAlignment     =NSTextAlignmentLeft;
        [self addSubview:titleL];
        
        imageView                =[[UIImageView alloc] init];
        [self addSubview:imageView];
        
        iconView                 =[[UIImageView alloc] init];
        [self addSubview:iconView];
        
        nameL                    =[[UILabel alloc] init];
        nameL.font               =[UIFont systemFontOfSize:12*LSScale];
        nameL.textAlignment      =NSTextAlignmentLeft;
        nameL.textColor          =[UIColor darkGrayColor];
        [self addSubview:nameL];
        
        timeView                 =[[UIImageView alloc] init];
        [self addSubview:timeView];
        
        perNumView               =[[UIImageView alloc] init];
        [self addSubview:perNumView];
        
        timeL                    =[[UILabel alloc] init];
        timeL.font               =[UIFont systemFontOfSize:12*LSScale];
        timeL.textAlignment      =NSTextAlignmentLeft;
        timeL.textColor          =[UIColor darkGrayColor];
        [self addSubview:timeL];
        
        perNumL                    =[[UILabel alloc] init];
        perNumL.font               =[UIFont systemFontOfSize:12*LSScale];
        perNumL.textAlignment      =NSTextAlignmentLeft;
        perNumL.textColor          =[UIColor darkGrayColor];
        [self addSubview:perNumL];
    }
    return self;
}

-(void)reloadCell:(LsDataModel *)model Image:(BOOL)haveImage{
    if (haveImage) {
        
    }else{
        
    }
}

@end
