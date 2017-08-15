//
//  LsLiveTableViewCell.m
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveTableViewCell.h"

@interface LsLiveTableViewCell ()
{
    UILabel           *titleL;
    UILabel           *timeL;
    UIImageView       *teaOneIV ;
    UILabel           *teacherLOne;
    UIImageView       *teaTwoIV ;
    UILabel           *teacherLTwo;
}

@end

@implementation LsLiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor    =[UIColor whiteColor];
        titleL        =[[UILabel alloc] initWithFrame:CGRectMake(20, 10*LSScale, LSMainScreenW-40, 20*LSScale)];
//        titleL.font             =[UIFont fontWithName:@"Helvetica-Bold" size:14];
        titleL.font             =[UIFont systemFontOfSize:14];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [self addSubview:titleL];
        
        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
        UIImageView  *timeIV    =[[UIImageView alloc] initWithFrame:CGRectMake(20,42.5*LSScale-image.size.height/2, image.size.width, image.size.height)];
        timeIV.image            =image;
        [self addSubview:timeIV];
        
        timeL         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIV.frame)+10, 32.5*LSScale, LSMainScreenW-90, 20*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:12.5];
        timeL.textColor         =LSColor(153, 153, 153, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [self addSubview:timeL];
        
        teaOneIV  =[[UIImageView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(timeL.frame)+5*LSScale, 20*LSScale, 20*LSScale)];
        teaOneIV.layer.cornerRadius      =10*LSScale;
        teaOneIV.layer.masksToBounds      =YES;
        [self addSubview:teaOneIV];
        
        teacherLOne    =[[UILabel alloc]  initWithFrame:CGRectMake(20, CGRectGetMaxY(teaOneIV.frame), 35*LSScale, 20*LSScale)];
        teacherLOne.font            =[UIFont systemFontOfSize:10];
        teacherLOne.textColor       =LSColor(153, 153, 153, 1);
        [self addSubview:teacherLOne];
        
        teaTwoIV  =[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(teaOneIV.frame)+20, CGRectGetMaxY(timeL.frame)+5*LSScale, 20*LSScale, 20*LSScale)];
        teaTwoIV.layer.cornerRadius =10*LSScale;
        teaTwoIV.layer.masksToBounds      =YES;
        [self addSubview:teaTwoIV];
        
        teacherLTwo    =[[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMidX(teaTwoIV.frame)-17.5*LSScale, CGRectGetMaxY(teaTwoIV.frame), 35*LSScale, 20*LSScale)];
        teacherLTwo.font            =[UIFont systemFontOfSize:10];
        teacherLTwo.textColor       =LSColor(153, 153, 153, 1);
        [self addSubview:teacherLTwo];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, 100*LSScale-0.5, LSMainScreenW, 0.5)];
        line.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

-(void)reloadCell:(LsLiveModel*)model{
    titleL.text =model.title;
    NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy-MM-dd"];
    NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
    NSString *endTime   =[LsMethod toDateWithTimeStamp:model.endTime   DateFormat:@"HH:mm"];

    timeL.text  =[NSString stringWithFormat:@"%@  %@-%@",startDate,startTime,endTime];
    [teaOneIV sd_setImageWithURL:[NSURL URLWithString:[model.teacherArray[0] teacherIcon]] placeholderImage:[UIImage imageNamed:@"default"]];
    teacherLOne.text =[model.teacherArray[0] teacherName];
    [teaTwoIV sd_setImageWithURL:[NSURL URLWithString:[model.teacherArray[1] teacherIcon]] placeholderImage:[UIImage imageNamed:@"default"]];
    teacherLTwo.text =[model.teacherArray[1] teacherName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
