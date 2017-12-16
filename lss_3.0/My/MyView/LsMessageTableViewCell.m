//
//  LsMessageTableViewCell.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMessageTableViewCell.h"

@interface LsMessageTableViewCell ()
{
    UILabel      *title_;
    UILabel      *detailTitle_;
    UIView       *baseView;
}
@end

@implementation LsMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 50*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
        title_                 =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale,5*LSScale,200*LSScale, 40*LSScale)];
        title_.numberOfLines   =0;
        title_.textAlignment   =NSTextAlignmentLeft;
        title_.font            =[UIFont systemFontOfSize:15*LSScale];
        [baseView addSubview:title_];
        
        detailTitle_                 =[[UILabel alloc] init];
        detailTitle_.textAlignment   =NSTextAlignmentLeft;
        detailTitle_.font            =[UIFont systemFontOfSize:13*LSScale];
        [baseView addSubview:detailTitle_];
        
        UIView  *line          =[[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
        line.backgroundColor  =LSLineColor;
        [baseView addSubview:line];
        
    }
    return self;
}


-(void)reloadCellWithData:(LsMessageModel*)data{
    title_.text         =data.title;
    detailTitle_.text   =data.createTime;
    CGSize  size        =[LsMethod sizeWithString:data.createTime font:detailTitle_.font];
    detailTitle_.frame  =CGRectMake(LSMainScreenW-10*LSScale-size.width, 10*LSScale, size.width, 30*LSScale);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
