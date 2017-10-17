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
    
    UIView      *backgroundView;
}
@end

@implementation LsDataTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor      =LSColor(243, 244, 245, 1);
        backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10*LSScale)];
        backgroundView.backgroundColor =[UIColor whiteColor];
        [self addSubview:backgroundView];
        
        titleL                   =[[UILabel alloc] init];
        titleL.font              =[UIFont systemFontOfSize:15*LSScale];
        titleL.textAlignment     =NSTextAlignmentLeft;
        [backgroundView addSubview:titleL];
        
        imageView                =[[UIImageView alloc] init];
        [backgroundView addSubview:imageView];
        
        iconView                 =[[UIImageView alloc] init];
        [backgroundView addSubview:iconView];
        
        nameL                    =[[UILabel alloc] init];
        nameL.font               =[UIFont systemFontOfSize:12*LSScale];
        nameL.textAlignment      =NSTextAlignmentLeft;
        nameL.textColor          =[UIColor darkGrayColor];
        [backgroundView addSubview:nameL];
        
        timeView                 =[[UIImageView alloc] init];
        [backgroundView addSubview:timeView];
        
        perNumView               =[[UIImageView alloc] init];
        [backgroundView addSubview:perNumView];
        
        timeL                    =[[UILabel alloc] init];
        timeL.font               =[UIFont systemFontOfSize:12*LSScale];
        timeL.textAlignment      =NSTextAlignmentLeft;
        timeL.textColor          =[UIColor darkGrayColor];
        [backgroundView addSubview:timeL];
        
        perNumL                    =[[UILabel alloc] init];
        perNumL.font               =[UIFont systemFontOfSize:12*LSScale];
        perNumL.textAlignment      =NSTextAlignmentLeft;
        perNumL.textColor          =[UIColor darkGrayColor];
        [backgroundView addSubview:perNumL];
    }
    return self;
}

-(void)reloadCell:(LsDataDetailModel *)model{
    
    if ([LsMethod haveValue:model.headImgUrl]) {
        imageView.frame  =CGRectMake(15*LSScale, 10*LSScale, 60*LSScale, 60*LSScale);
        imageView.contentMode =UIViewContentModeScaleAspectFit;
        titleL.frame     =CGRectMake(CGRectGetMaxX(imageView.frame)+15*LSScale, 15*LSScale, LSMainScreenW-15*LSScale-CGRectGetMaxX(imageView.frame), 25*LSScale);
//        iconView.frame   =CGRectMake(CGRectGetMaxX(imageView.frame)+15*LSScale, 40*LSScale, 25*LSScale, 25*LSScale);
//        iconView.backgroundColor   =[UIColor redColor];
        nameL.frame      =CGRectMake(CGRectGetMaxX(imageView.frame)+15*LSScale, 40*LSScale, 80*LSScale, 25*LSScale);
        nameL.textAlignment =NSTextAlignmentLeft;
 
        [imageView sd_setImageWithURL:model.headImgUrl placeholderImage:[UIImage imageNamed:@""]];
    }else{
        titleL.frame     =CGRectMake(15*LSScale, 10*LSScale, LSMainScreenW-15*LSScale, 20*LSScale);
//        iconView.frame   =CGRectMake(15*LSScale, 35*LSScale, 25*LSScale, 25*LSScale);
//        iconView.backgroundColor   =[UIColor redColor];
        nameL.frame      =CGRectMake(15*LSScale, 35*LSScale, 80*LSScale, 25*LSScale);
        nameL.textAlignment =NSTextAlignmentLeft;
    }

    timeL.frame  =CGRectMake(LSMainScreenW-15*LSScale-80*LSScale, CGRectGetMinY(nameL.frame), 80*LSScale, 20*LSScale);
    NSString  *timeStr = [LsMethod dateStrFromDate:model.createTime AndFormat:@"yyyy.MM.dd"];
    CGSize timeSize   =[LsMethod sizeWithString:timeStr font:[UIFont systemFontOfSize:12*LSScale]];
    UIImage  *timeImage  =[UIImage imageNamed:@"time_icon"];
    timeL.frame  =CGRectMake(LSMainScreenW-15*LSScale-timeSize.width, CGRectGetMinY(nameL.frame), timeSize.width, 20*LSScale);

    timeView.frame  =CGRectMake(CGRectGetMinX(timeL.frame)-timeImage.size.width-5*LSScale, CGRectGetMidY(timeL.frame)-timeImage.size.height/2, timeImage.size.width, timeImage.size.height);
    timeView.image  =timeImage;
    perNumL.frame   =CGRectMake(LSMainScreenW-15*LSScale-40*LSScale, CGRectGetMaxY(timeL.frame), 40*LSScale, 20*LSScale);
    NSString  *perNumStr = model.viewTime;
    CGSize perNumSize=[LsMethod sizeWithString:perNumStr font:[UIFont systemFontOfSize:12*LSScale]];
    perNumL.frame   =CGRectMake(LSMainScreenW-15*LSScale-perNumSize.width, CGRectGetMaxY(timeL.frame), perNumSize.width, 20*LSScale);
    
    UIImage  *perNumImage  =[UIImage imageNamed:@"yj"];
    perNumView.frame =CGRectMake(CGRectGetMinX(perNumL.frame)-perNumImage.size.width-5*LSScale, CGRectGetMidY(perNumL.frame)-perNumImage.size.height/2, perNumImage.size.width, perNumImage.size.height);
    perNumView.image =perNumImage;
    backgroundView.frame =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(perNumView.frame)+10*LSScale);
    self.frame =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(backgroundView.frame)+10*LSScale);
    titleL.text                =model.title;
    nameL.text                 =model.creator;
    timeL.text                 =timeStr;
    perNumL.text               =model.viewTime;
    

}

@end
