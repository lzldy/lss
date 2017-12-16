//
//  LsWrittenTableViewCell.m
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWrittenTableViewCell.h"
@interface LsWrittenTableViewCell ()
{
    UILabel      *title_;
    UILabel      *detailTitle_;
    UILabel      *label1;
    UILabel      *label2;

    UIView       *baseView;
}
@end

@implementation LsWrittenTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {       
        self.backgroundColor     =[UIColor clearColor];
        
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 65*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
        title_                 =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale,5*LSScale,LSMainScreenW-30*LSScale,35*LSScale)];
        title_.numberOfLines   =0;
        title_.textAlignment   =NSTextAlignmentLeft;
        title_.font            =[UIFont systemFontOfSize:14.5*LSScale];
        title_.textColor       =LSColor(35, 34, 34, 1);
        [baseView addSubview:title_];
        
        detailTitle_                 =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, CGRectGetMaxY(title_.frame),LSMainScreenW/2, 15*LSScale)];
        detailTitle_.textAlignment   =NSTextAlignmentLeft;
        detailTitle_.font            =[UIFont systemFontOfSize:13*LSScale];
        detailTitle_.textColor       =LSColor(135, 134, 134, 1);
        [baseView addSubview:detailTitle_];
        
        label1                 =[[UILabel alloc] init];
        label1.textAlignment   =NSTextAlignmentLeft;
        label1.font            =[UIFont systemFontOfSize:12.5*LSScale];
        label1.textColor       =LSColor(135, 134, 134, 1);
        [baseView addSubview:label1];
        
        label2                 =[[UILabel alloc] init];
        label2.textAlignment   =NSTextAlignmentLeft;
        label2.font            =[UIFont systemFontOfSize:12.5*LSScale];
        label2.textColor       =LSColor(135, 134, 134, 1);
        [baseView addSubview:label2];
        
        UIView  *line          =[[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
        line.backgroundColor  =LSLineColor;
        [baseView addSubview:line];

    }
    return self;
}

-(void)reloadCellWithData:(LsQuestionsDetailModel*)data{
    title_.text          =data.name;
    detailTitle_.text    =[NSString stringWithFormat:@"练习次数:%@次",data.totalExeNum];
    
    label2.text          =[NSString stringWithFormat:@"最高做对%@道",data.maxCorrQuestNum];
    CGSize  size2        =[LsMethod sizeWithString:label2.text font:label2.font];
    label2.frame         =CGRectMake(LSMainScreenW-10*LSScale-size2.width, CGRectGetMinY(detailTitle_.frame), size2.width, 15*LSScale);
    label2.attributedText=[LsMethod changeColorWithStr:label2.text RangeStr:data.maxCorrQuestNum];
    
    label1.text          =[NSString stringWithFormat:@"共%@道题",data.parsedQuestNum];
    CGSize  size1        =[LsMethod sizeWithString:label1.text font:label1.font];
    label1.frame         =CGRectMake(CGRectGetMinX(label2.frame)-5*LSScale-size1.width, CGRectGetMinY(detailTitle_.frame), size1.width, 15*LSScale);
    label1.attributedText=[LsMethod changeColorWithStr:label1.text RangeStr:data.parsedQuestNum];
}

@end
