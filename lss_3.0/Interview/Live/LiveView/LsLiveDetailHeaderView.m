//
//  LsLiveDetailHeaderView.m
//  lss
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailHeaderView.h"

@interface LsLiveDetailHeaderView ()
{
    UIButton *courseArrangementBtn;
    UIButton *courseIntroductionBtn;
}

@end

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

    UILabel  *titleL                 =[[UILabel alloc] initWithFrame:CGRectMake(10, 10*LSScale, self.frame.size.width-30, 25*LSScale)];
    titleL.text                      =model.title;
    titleL.textAlignment             =NSTextAlignmentLeft;
    titleL.font                      =[UIFont systemFontOfSize:15*LSScale];
    titleL.textColor                 =LSNavColor;
    [self addSubview:titleL];
    
    UIView   *line1                  =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame)+10, 1, 40*LSScale)];
    line1.backgroundColor            =LSLineColor;
    [self addSubview:line1];
    
    UILabel  *classHoursL            =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+3, CGRectGetMinY(line1.frame), 80, 20*LSScale)];
    classHoursL.text                 =@"课时总计";
    classHoursL.font                 =[UIFont systemFontOfSize:12*LSScale];
    classHoursL.textColor            =[UIColor darkGrayColor];
    classHoursL.textAlignment        =NSTextAlignmentCenter;
    CGSize size                      =[LsMethod sizeWithString:classHoursL.text font:classHoursL.font];
    classHoursL.frame                =CGRectMake(classHoursL.frame.origin.x, classHoursL.frame.origin.y, size.width*LSScale+18*LSScale, classHoursL.frame.size.height);
    [self addSubview:classHoursL];
    
    UILabel  *classHoursText         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+3, CGRectGetMaxY(line1.frame)-20*LSScale, CGRectGetWidth(classHoursL.frame), 20*LSScale)];
    classHoursText.text              =[NSString stringWithFormat:@"%@课时",model.classHours];
    classHoursText.font              =[UIFont systemFontOfSize:12*LSScale];
    classHoursText.textColor         =[UIColor darkTextColor];
    classHoursText.textAlignment     =NSTextAlignmentCenter;
    [self addSubview:classHoursText];
    
    UIView   *line2                  =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(classHoursL.frame), CGRectGetMaxY(titleL.frame)+10, 1, 40*LSScale)];
    line2.backgroundColor            =LSLineColor;
    [self addSubview:line2];
    
    UILabel  *personNumL            =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame)+3, CGRectGetMinY(line2.frame), 80, 20*LSScale)];
    personNumL.text                 =@"报名人数";
    personNumL.font                 =[UIFont systemFontOfSize:12*LSScale];
    personNumL.textColor            =[UIColor darkGrayColor];
    personNumL.textAlignment        =NSTextAlignmentCenter;
    CGSize size1                    =[LsMethod sizeWithString:personNumL.text font:personNumL.font];
    personNumL.frame                =CGRectMake(personNumL.frame.origin.x, personNumL.frame.origin.y, size1.width*LSScale+18*LSScale, personNumL.frame.size.height);
    [self addSubview:personNumL];
    
    UILabel  *personNumText         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame)+3, CGRectGetMaxY(line2.frame)-20*LSScale, CGRectGetWidth(personNumL.frame), 20*LSScale)];
    personNumText.text              =[NSString stringWithFormat:@"%ld人",(long)model.personNum];
    personNumText.font              =[UIFont systemFontOfSize:12*LSScale];
    personNumText.textColor         =[UIColor darkTextColor];
    personNumText.textAlignment     =NSTextAlignmentCenter;
    [self addSubview:personNumText];
    
    UIView   *line3                  =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(personNumL.frame), CGRectGetMaxY(titleL.frame)+10, 1, 40*LSScale)];
    line3.backgroundColor            =LSLineColor;
    [self addSubview:line3];
    
    UILabel  *timeL                  =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line3.frame)+3, CGRectGetMinY(line3.frame), self.frame.size.width-CGRectGetMaxX(line3.frame), 20*LSScale)];
    timeL.text                       =@"直播时间";
    timeL.font                       =[UIFont systemFontOfSize:12*LSScale];
    timeL.textColor                  =[UIColor darkGrayColor];
    timeL.textAlignment              =NSTextAlignmentCenter;
//    CGSize size2                     =[LsMethod sizeWithString:timeL.text font:timeL.font];
//    timeL.frame                      =CGRectMake(timeL.frame.origin.x, timeL.frame.origin.y, size2.width*LSScale+18*LSScale, timeL.frame.size.height);
    [self addSubview:timeL];
    
    UILabel  *timeText         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line3.frame)+3, CGRectGetMaxY(line3.frame)-20*LSScale,CGRectGetWidth(timeL.frame), 20*LSScale)];
    timeText.font              =[UIFont systemFontOfSize:12*LSScale];
    timeText.textColor         =[UIColor darkTextColor];
    timeText.textAlignment     =NSTextAlignmentCenter;
    [self addSubview:timeText];

    NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy.MM.dd"];
    NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDate   DateFormat:@"MM.dd"];
    NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
    if (model.isPackage) {
        timeText.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
    }else{
        timeText.text  =[NSString stringWithFormat:@"%@ %@",startDate,startTime];
    }
//    CGSize size3                     =[LsMethod sizeWithString:timeText.text font:timeText.font];
//    timeText.frame                      =CGRectMake(timeText.frame.origin.x, timeText.frame.origin.y, size3.width*LSScale, timeText.frame.size.height);
    
//    model.isPackage  =NO;
//    if (model.isPackage) {
    
        UIView *line  =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(classHoursText.frame)+10, self.frame.size.width, 0.5)];
        line.backgroundColor  =LSLineColor;
        [self addSubview:line];
        
        courseArrangementBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/4-45*LSScale, CGRectGetMaxY(line.frame)+7.5*LSScale, 90*LSScale, 20*LSScale)];
        [courseArrangementBtn setImage:[UIImage imageNamed:@"details_button_before"] forState:UIControlStateNormal];
        [courseArrangementBtn setImage:[UIImage imageNamed:@"details_button_after"] forState:UIControlStateSelected];
        [courseArrangementBtn setTitle:@"课程安排" forState:UIControlStateNormal];
        courseArrangementBtn.titleLabel.font   =[UIFont systemFontOfSize:14*LSScale];
        [courseArrangementBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [courseArrangementBtn setTitleColor:LSNavColor forState:UIControlStateSelected];
        courseArrangementBtn.selected =YES;
        courseArrangementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [courseArrangementBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0.0,0.0)];
        [courseArrangementBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        courseArrangementBtn.tag=0;
        [self addSubview:courseArrangementBtn];
        
        UIView *midLine  =[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-0.25, CGRectGetMaxY(classHoursText.frame)+10, 0.5, 35*LSScale)];
        midLine.backgroundColor  =LSLineColor;
        [self addSubview:midLine];
        
        courseIntroductionBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/4*3-45*LSScale, CGRectGetMaxY(line.frame)+7.5*LSScale, 90*LSScale, 20*LSScale)];
        [courseIntroductionBtn setImage:[UIImage imageNamed:@"kcjs_buttong_before"] forState:UIControlStateNormal];
        [courseIntroductionBtn setImage:[UIImage imageNamed:@"kcjs_buttong_after"] forState:UIControlStateSelected];
        [courseIntroductionBtn setTitle:@"课程介绍" forState:UIControlStateNormal];
        courseIntroductionBtn.titleLabel.font   =[UIFont systemFontOfSize:14*LSScale];
        [courseIntroductionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [courseIntroductionBtn setTitleColor:LSNavColor forState:UIControlStateSelected];
        courseIntroductionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [courseIntroductionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0.0,0.0)];
        [courseIntroductionBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        courseIntroductionBtn.tag=1;
        [self addSubview:courseIntroductionBtn];

        self.frame  =CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(midLine.frame));
//    }else{
//        self.frame  =CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(classHoursText.frame)+10);
//    }
}

-(void)clickBtn:(UIButton *)button{
    button.selected=YES;
    if (button.tag==0) {
        courseIntroductionBtn.selected=NO;
    }else{
        courseArrangementBtn.selected =NO;
    }
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickBtnIndex:)]) {
        [self.delegate didClickBtnIndex:button.tag];
    }
}


@end
