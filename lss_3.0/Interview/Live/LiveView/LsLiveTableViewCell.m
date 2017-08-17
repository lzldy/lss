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
    UILabel           *personNumL;
    UILabel           *stausL;
    UIImageView       *timeIV;
    
    UIImageView       *noDataImageView;
    UILabel           *noDataL;

}

@end

@implementation LsLiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor    =[UIColor whiteColor];
        titleL        =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 8*LSScale, LSMainScreenW-40, 25*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:17.5];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [self addSubview:titleL];

        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
        timeIV    =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale,CGRectGetMaxY(titleL.frame)+5*LSScale,15*LSScale, 15*LSScale)];
        [self addSubview:timeIV];
        
        timeL         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIV.frame)+10,CGRectGetMidY(timeIV.frame)-10*LSScale, LSMainScreenW-timeL.frame.origin.x, 20*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:16];
        timeL.textColor         =LSColor(153, 153, 153, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [self addSubview:timeL];
        
        teaOneIV  =[[UIImageView alloc] initWithFrame:CGRectMake(17*LSScale, CGRectGetMaxY(timeL.frame)+10*LSScale, 30*LSScale, 30*LSScale)];
        teaOneIV.layer.cornerRadius       =15*LSScale;
        teaOneIV.layer.masksToBounds      =YES;
        [self addSubview:teaOneIV];
        
        teacherLOne    =[[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMidX(teaOneIV.frame)-22.5*LSScale, CGRectGetMaxY(teaOneIV.frame), 45*LSScale, 20*LSScale)];
        teacherLOne.font            =[UIFont systemFontOfSize:14];
        teacherLOne.textAlignment   =NSTextAlignmentCenter;
        teacherLOne.textColor       =LSColor(153, 153, 153, 1);
        [self addSubview:teacherLOne];
        
        teaTwoIV  =[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(teaOneIV.frame)+20*LSScale, CGRectGetMaxY(timeL.frame)+10*LSScale, 30*LSScale, 30*LSScale)];
        teaTwoIV.layer.cornerRadius       =15*LSScale;
        teaTwoIV.layer.masksToBounds      =YES;
        [self addSubview:teaTwoIV];
        
        teacherLTwo    =[[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMidX(teaTwoIV.frame)-22.5*LSScale, CGRectGetMaxY(teaTwoIV.frame), 45*LSScale, 20*LSScale)];
        teacherLTwo.font            =[UIFont systemFontOfSize:14];
        teacherLTwo.textAlignment   =NSTextAlignmentCenter;
        teacherLTwo.textColor       =LSColor(153, 153, 153, 1);
        [self addSubview:teacherLTwo];
        
        personNumL   =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW-120,CGRectGetMinY(teacherLOne.frame) , 110, 20*LSScale)];
        personNumL.textAlignment =NSTextAlignmentRight;
        personNumL.textColor     =LSColor(153, 153, 153, 1);
        personNumL.font          =[UIFont systemFontOfSize:14];
        [self addSubview:personNumL];
        
        stausL       =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW-100, CGRectGetMinY(personNumL.frame)-20*LSScale, 90, 20*LSScale)];
        stausL.textColor       =LSColor(255, 90, 122, 1);
        stausL.font            =[UIFont systemFontOfSize:15.5];
        stausL.textAlignment   =NSTextAlignmentRight;
        [self addSubview:stausL];
        
        UIImage  *iamge        =[UIImage imageNamed:@"kym_icon"];
        noDataImageView        =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-iamge.size.width/2, 15*LSScale, iamge.size.width, image.size.height)];
        [self addSubview:noDataImageView];
        
        noDataL                =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noDataImageView.frame)+5, LSMainScreenW, 25*LSScale)];
        noDataL.textAlignment  =NSTextAlignmentCenter;
        noDataL.font           =[UIFont systemFontOfSize:15];
        noDataL.textColor      =[UIColor darkTextColor];
        [self addSubview:noDataL];
        
        UIView *line           =[[UIView alloc] initWithFrame:CGRectMake(0, 125*LSScale-0.5, LSMainScreenW, 0.5)];
        line.backgroundColor   =LSLineColor;
        [self addSubview:line];
    }
    return self;
}

-(void)reloadCell:(LsLiveModel*)model Type:(NSString*)type{
    if ([type isEqualToString:@"1"]) {
        noDataImageView.hidden  =YES;
        noDataL.hidden          =YES;
        titleL.text =model.title;
        
        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
        timeIV.image            =image;
        
        NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy-MM-dd"];
        NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDate   DateFormat:@"yyyy-MM-dd"];
        NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
        NSString *endTime   =[LsMethod toDateWithTimeStamp:model.endTime   DateFormat:@"HH:mm"];
        if (model.isPackage) {
            timeL.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
        }else{
            timeL.text  =[NSString stringWithFormat:@"%@  %@-%@",startDate,startTime,endTime];
        }
       
        if (model.teacherArray.count>0) {
            [teaOneIV sd_setImageWithURL:[NSURL URLWithString:[model.teacherArray[0] teacherIcon]] placeholderImage:[UIImage imageNamed:@"default"]];
            teacherLOne.text     =[model.teacherArray[0] teacherName];
            if (model.teacherArray.count>1) {
                [teaTwoIV sd_setImageWithURL:[NSURL URLWithString:[model.teacherArray[1] teacherIcon]] placeholderImage:[UIImage imageNamed:@"default"]];
                teacherLTwo.text =[model.teacherArray[1] teacherName];
            }
        }
        personNumL.text          =[NSString stringWithFormat:@"已有%ld人报名",(long)model.personNum];
        stausL.text              =@"正在报名";

    }else{
        noDataImageView.hidden   =NO;
        noDataL.hidden           =NO;
        UIImage  *iamge          =[UIImage imageNamed:@"kym_icon"];
        noDataImageView.image    =iamge;
        noDataL.text             =@"暂时没有直播,快去看看回放吧~";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
