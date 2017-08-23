//
//  LsLiveDetailHeaderView.m
//  lss
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailHeaderView.h"

@implementation LsLiveDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius =6;
        self.backgroundColor    =[UIColor whiteColor];
    }
    return self;
}



-(void)setModel:(LsLiveDetailModel *)model{
    _model=model;

    UILabel  *titleL                 =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-30, 25)];
    titleL.text                      =model.title;
    titleL.textAlignment             =NSTextAlignmentLeft;
    titleL.font                      =[UIFont systemFontOfSize:15*LSScale];
    titleL.textColor                 =LSNavColor;
    [self addSubview:titleL];
    
    UIView   *line1                  =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame)+10, 1, 50)];
    line1.backgroundColor            =LSLineColor;
    [self addSubview:line1];
    
    UILabel  *classHoursL            =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+3, CGRectGetMinY(line1.frame), 80, 20)];
    classHoursL.text                 =@"课时总计";
    classHoursL.font                 =[UIFont systemFontOfSize:12*LSScale];
    classHoursL.textColor            =[UIColor darkGrayColor];
    classHoursL.textAlignment        =NSTextAlignmentLeft;
    CGSize size                      =[LsMethod sizeWithString:classHoursL.text font:classHoursL.font];
    classHoursL.frame                =CGRectMake(classHoursL.frame.origin.x, classHoursL.frame.origin.y, size.width*LSScale, classHoursL.frame.size.height);
    [self addSubview:classHoursL];
    
    UILabel  *classHoursText         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+3, CGRectGetMaxY(line1.frame)-20, 80, 20)];
    classHoursText.text              =[NSString stringWithFormat:@"%@课时",model.classHours];
    classHoursText.font              =[UIFont systemFontOfSize:12*LSScale];
    classHoursText.textColor         =[UIColor darkTextColor];
    classHoursText.textAlignment     =NSTextAlignmentLeft;
    [self addSubview:classHoursText];
    
    UIView   *line2                  =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(classHoursL.frame)+18*LSScale, CGRectGetMaxY(titleL.frame)+10, 1, 50)];
    line2.backgroundColor            =LSLineColor;
    [self addSubview:line2];
    
    UILabel  *personNumL            =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame)+3, CGRectGetMinY(line2.frame), 80, 20)];
    personNumL.text                 =@"报名人数";
    personNumL.font                 =[UIFont systemFontOfSize:12*LSScale];
    personNumL.textColor            =[UIColor darkGrayColor];
    personNumL.textAlignment        =NSTextAlignmentLeft;
    CGSize size1                    =[LsMethod sizeWithString:personNumL.text font:personNumL.font];
    personNumL.frame                =CGRectMake(personNumL.frame.origin.x, personNumL.frame.origin.y, size1.width*LSScale, personNumL.frame.size.height);
    [self addSubview:personNumL];
    
    UILabel  *personNumText         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame)+3, CGRectGetMaxY(line2.frame)-20, 80, 20)];
    personNumText.text              =[NSString stringWithFormat:@"%ld人",(long)model.personNum];
    personNumText.font              =[UIFont systemFontOfSize:12*LSScale];
    personNumText.textColor         =[UIColor darkTextColor];
    personNumText.textAlignment     =NSTextAlignmentLeft;
    [self addSubview:personNumText];
    
    UIView   *line3                  =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(personNumL.frame)+18*LSScale, CGRectGetMaxY(titleL.frame)+10, 1, 50)];
    line3.backgroundColor            =LSLineColor;
    [self addSubview:line3];
    
    UILabel  *timeL                  =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line3.frame)+3, CGRectGetMinY(line3.frame), 80, 20)];
    timeL.text                       =@"直播时间";
    timeL.font                       =[UIFont systemFontOfSize:12*LSScale];
    timeL.textColor                  =[UIColor darkGrayColor];
    timeL.textAlignment              =NSTextAlignmentLeft;
    CGSize size2                     =[LsMethod sizeWithString:timeL.text font:timeL.font];
    timeL.frame                      =CGRectMake(timeL.frame.origin.x, timeL.frame.origin.y, size2.width*LSScale, timeL.frame.size.height);
    [self addSubview:timeL];
    
    UILabel  *timeText         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line3.frame)+3, CGRectGetMaxY(line3.frame)-20, 80, 20)];
    timeText.font              =[UIFont systemFontOfSize:12*LSScale];
    timeText.textColor         =[UIColor darkTextColor];
    timeText.textAlignment     =NSTextAlignmentLeft;
    [self addSubview:timeText];

    NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy.MM.dd"];
    NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDate   DateFormat:@"yyyy.MM.dd"];
    NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
    if (model.isPackage) {
        timeText.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
    }else{
        timeText.text  =[NSString stringWithFormat:@"%@ %@",startDate,startTime];
    }
    CGSize size3                     =[LsMethod sizeWithString:timeText.text font:timeText.font];
    timeText.frame                      =CGRectMake(timeText.frame.origin.x, timeText.frame.origin.y, size3.width*LSScale, timeText.frame.size.height);
    
    model.isPackage  =NO;
    if (model.isPackage) {
        
        self.frame  =CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 130);
    }else{
        self.frame  =CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(classHoursText.frame)+10);
    }
}
@end
