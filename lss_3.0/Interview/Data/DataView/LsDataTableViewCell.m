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

-(void)reloadCell:(LsDataDetailModel *)model{
    
    if ([LsMethod haveValue:model.imgUrl]) {
        imageView.frame  =CGRectMake(15*LSScale, 10*LSScale, 60*LSScale, 60*LSScale);
        imageView.backgroundColor  =[UIColor greenColor];
        titleL.frame     =CGRectMake(CGRectGetMaxX(imageView.frame)+15*LSScale, 15*LSScale, LSMainScreenW-15*LSScale-CGRectGetMaxX(imageView.frame), 25*LSScale);
        titleL.backgroundColor     =[UIColor cyanColor];
        iconView.frame   =CGRectMake(CGRectGetMaxX(imageView.frame)+15*LSScale, 40*LSScale, 25*LSScale, 25*LSScale);
        iconView.backgroundColor   =[UIColor redColor];
        nameL.frame      =CGRectMake(CGRectGetMaxX(iconView.frame)+10*LSScale, 40*LSScale, 80*LSScale, 25*LSScale);
        nameL.textAlignment =NSTextAlignmentLeft;
        nameL.backgroundColor      =[UIColor brownColor];


    }else{
        titleL.frame     =CGRectMake(15*LSScale, 10*LSScale, LSMainScreenW-15*LSScale, 20*LSScale);
        titleL.backgroundColor     =[UIColor cyanColor];
        iconView.frame   =CGRectMake(15*LSScale, 35*LSScale, 25*LSScale, 25*LSScale);
        iconView.backgroundColor   =[UIColor redColor];
        nameL.frame      =CGRectMake(CGRectGetMaxX(iconView.frame)+10*LSScale, 35*LSScale, 80*LSScale, 25*LSScale);
        nameL.textAlignment =NSTextAlignmentLeft;
        nameL.backgroundColor      =[UIColor brownColor];
    }
    
    timeL.frame  =CGRectMake(LSMainScreenW-15*LSScale-80*LSScale, CGRectGetMinY(iconView.frame), 80*LSScale, 20*LSScale);
    timeL.backgroundColor =[UIColor redColor];
    UIImage  *timeImage  =[UIImage imageNamed:@"time_icon"];
    timeView.frame  =CGRectMake(CGRectGetMinX(timeL.frame)-5*LSScale-20*LSScale, CGRectGetMidY(timeL.frame)-timeImage.size.height/2, timeImage.size.width, timeImage.size.height);
    timeView.image  =timeImage;
    perNumL.frame   =CGRectMake(LSMainScreenW-15*LSScale-40*LSScale, CGRectGetMaxY(timeL.frame), 40*LSScale, 20*LSScale);
    perNumL.backgroundColor =[UIColor brownColor];
    UIImage  *perNumImage  =[UIImage imageNamed:@"yj"];
    perNumView.frame =CGRectMake(CGRectGetMinX(perNumL.frame)-5*LSScale-20*LSScale, CGRectGetMidY(perNumL.frame)-perNumImage.size.height/2, perNumImage.size.width, perNumImage.size.height);
    perNumView.image =perNumImage;
    self.frame =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(perNumView.frame)+10*LSScale);
    
}

@end
