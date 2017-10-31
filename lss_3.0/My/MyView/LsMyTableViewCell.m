//
//  LsMyTableViewCell.m
//  lss
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyTableViewCell.h"

@interface LsMyTableViewCell ()
{
    UIImageView  *imageView_;
    UILabel      *title_;
}
@end

@implementation LsMyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView_             =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale, 5*LSScale, 35*LSScale, 35*LSScale)];
        [self addSubview:imageView_];
        
        title_                 =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView_.frame), 7.5*LSScale, 120*LSScale, 30*LSScale)];
        title_.textAlignment   =NSTextAlignmentLeft;
        title_.font            =[UIFont systemFontOfSize:13*LSScale];
        [self addSubview:title_];
        
        UIImage   *image                      =[UIImage imageNamed:@"jrxyj_icon"];
        UIImageView    *imageView1            =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW-20*LSScale-15*LSScale-image.size.width, 45*LSScale/2-image.size.height/2, image.size.width, image.size.height)];
        imageView1.image                      =image;
        [self addSubview:imageView1];
        
    }
    return self;
}

-(void)reloadCellWithData:(NSDictionary *)data{
    NSString  *title   =data[@"title"];
    UIImage   *image   =[UIImage imageNamed:data[@"image"]];
    
    imageView_.image   =image;
    imageView_.frame   =CGRectMake(15*LSScale, 45*LSScale/2-image.size.height/2, image.size.width, image.size.height);
    
    title_.text        =title;
    title_.frame       =CGRectMake(CGRectGetMaxX(imageView_.frame)+7.5*LSScale, 7.5*LSScale, 120*LSScale, 30*LSScale);
}
@end
