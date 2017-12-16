//
//  LsMyOrderTableViewCell.m
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyOrderTableViewCell.h"

@interface LsMyOrderTableViewCell ()
{
    UILabel      *title_;
    UILabel      *detailTitle_;
    UILabel      *consumptionL_;

    UIView       *baseView;
}
@end

@implementation LsMyOrderTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 70*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
        title_                 =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale,10*LSScale,200*LSScale, 30*LSScale)];
        title_.numberOfLines   =0;
        title_.textAlignment   =NSTextAlignmentLeft;
        title_.font            =[UIFont systemFontOfSize:14.5*LSScale];
        [baseView addSubview:title_];
        
        detailTitle_                 =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(title_.frame), 200*LSScale, 20*LSScale)];
        detailTitle_.textAlignment   =NSTextAlignmentLeft;
        detailTitle_.font            =[UIFont systemFontOfSize:13.5*LSScale];
        detailTitle_.textColor       =LSColor(63, 61, 62, 1);
        [baseView addSubview:detailTitle_];
        
        consumptionL_                 =[[UILabel alloc] init];
        consumptionL_.textAlignment   =NSTextAlignmentLeft;
        consumptionL_.font            =[UIFont systemFontOfSize:15*LSScale];
        [baseView addSubview:consumptionL_];
        
        UIView  *line          =[[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
        line.backgroundColor  =LSLineColor;
        [baseView addSubview:line];
        
    }
    return self;
}


-(void)reloadCellWithData:(LsMyOrderModel*)data{
//    title_.text         =data.title;
//    detailTitle_.text   =data.createTime;
    title_.text         =@"2018年长沙面试考试直播";
    detailTitle_.text   =@"2018/01/01  王老师";
    NSString   *str     =@"23";
    NSString   *allStr  =[NSString stringWithFormat:@"消费%@元",str];
    
    CGSize      size    =[LsMethod sizeWithString:allStr font:consumptionL_.font];
    consumptionL_.frame =CGRectMake(LSMainScreenW-10*LSScale-size.width, 10*LSScale, size.width, 50*LSScale);
    consumptionL_.attributedText  =[LsMethod changeColorWithStr:allStr RangeStr:str];
    
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
