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
    UILabel           *personNumL;
    UIImageView       *stausL;
    UIImageView       *timeIV;
    
    UIImageView       *noDataImageView;
    UILabel           *noDataL;
    UIView            *baseView ;
    UIView            *line;
    UIView            *midLine;
    UIImageView       *imageV;
}

@end

@implementation LsLiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 10*LSScale, LSMainScreenW, 90*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];

        UIImage      *image_time     =LOADIMAGE(@"time_icon");
        timeIV    =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale,6*LSScale+14*LSScale/2-image_time.size.height/2,image_time.size.width, image_time.size.height)];
        [baseView addSubview:timeIV];
        
        timeL         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIV.frame)+5,6*LSScale, LSMainScreenW-timeL.frame.origin.x, 14*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:13.5];
        timeL.textColor         =LSColor(102, 102, 102, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:timeL];
        
        titleL        =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(timeL.frame)+5*LSScale, LSMainScreenW-40, 20*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:15];
        titleL.textColor        =LSColor(86, 85, 85, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:titleL];
        
        midLine    =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+4.5*LSScale, LSMainScreenW, 0.5)];
        midLine.backgroundColor  =LSLineColor;
        [baseView addSubview:midLine];
        
        stausL       =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW-50*LSScale-15*LSScale, CGRectGetMinY(midLine.frame)-12*LSScale-20*LSScale, 50*LSScale, 20*LSScale)];
        [baseView addSubview:stausL];
        
        teaOneIV  =[[UIImageView alloc] initWithFrame:CGRectMake(17*LSScale, CGRectGetMaxY(midLine.frame)+8*LSScale, 22*LSScale, 22*LSScale)];
        teaOneIV.layer.cornerRadius       =11*LSScale;
        teaOneIV.layer.masksToBounds      =YES;
        [baseView addSubview:teaOneIV];
        
        teacherLOne    =[[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(teaOneIV.frame)+10*LSScale, CGRectGetMidY(teaOneIV.frame)-6*LSScale, 100*LSScale, 12*LSScale)];
        teacherLOne.font            =[UIFont systemFontOfSize:13.8];
        teacherLOne.textAlignment   =NSTextAlignmentLeft;
        teacherLOne.textColor       =LSColor(153, 153, 153, 1);
        [baseView addSubview:teacherLOne];
        
        personNumL   =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW-120, CGRectGetMidY(teaOneIV.frame)-6*LSScale , 110, 12*LSScale)];
        personNumL.textAlignment =NSTextAlignmentRight;
        personNumL.textColor     =LSColor(153, 153, 153, 1);
        personNumL.font          =[UIFont systemFontOfSize:13.8];
        [baseView addSubview:personNumL];
        
        line           =[[UIView alloc] initWithFrame:CGRectMake(0, 90*LSScale-0.5, LSMainScreenW, 0.5)];
        line.backgroundColor   =LSLineColor;
        [baseView addSubview:line];
        
        UIImage  *iamge        =LOADIMAGE(@"kym_icon");
        noDataImageView        =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-iamge.size.width/2, 5*LSScale, iamge.size.width, iamge.size.height)];
        [baseView addSubview:noDataImageView];
        
        noDataL                =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noDataImageView.frame)+5, LSMainScreenW, 20*LSScale)];
        noDataL.textAlignment  =NSTextAlignmentCenter;
        noDataL.font           =[UIFont systemFontOfSize:15];
        noDataL.textColor      =[UIColor darkTextColor];
        [baseView addSubview:noDataL];

        imageV               =[[UIImageView alloc] init];
        imageV.hidden        =YES;
        [baseView addSubview:imageV];
        
        
    }
    return self;
}

-(void)reloadCell:(LsLiveModel*)model Type:(NSString*)type{
    
    if ([type isEqualToString:@"0"])//无数据
    {
        noDataImageView.hidden   =NO;
        noDataL.hidden           =NO;
        midLine.hidden           =YES;
        UIImage  *iamge          =LOADIMAGE(@"kym_icon");
        noDataImageView.image    =iamge;
        noDataL.text             =@"暂时没有直播,快去看看回放吧~";
    }else{
        noDataImageView.hidden  =YES;
        noDataL.hidden          =YES;
        midLine.hidden          =NO;
        imageV.hidden           =YES;
        titleL.text             =model.title;
        UIImage      *image     =LOADIMAGE(@"time_icon");
        timeIV.image            =image;
        
        NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy.MM.dd"];
        NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDate   DateFormat:@"yyyy.MM.dd"];
        NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
        if (model.isPackage) {
            startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy.MM.dd"];
            endDate   =[LsMethod toDateWithTimeStamp:model.endDate   DateFormat:@"yyyy.MM.dd"];
            timeL.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
        }else{
            timeL.text  =[NSString stringWithFormat:@"%@  %@开始",startDate,startTime];
        }
        
        UIImage      *ima    =LOADIMAGE(@"tuijian-icon");
        imageV.frame         =CGRectMake(CGRectGetMaxX(timeL.frame)+5, CGRectGetMidY(timeL.frame)-ima.size.height/2, ima.size.width, ima.size.height);
        if (model.isRecommend) {
            imageV.hidden=NO;
        }
        
        teaOneIV.image  =LOADIMAGE(@"tx-icon");
        if (model.teacherArray.count>0) {
            [teaOneIV sd_setImageWithURL:[NSURL URLWithString:[model.teacherArray[0] teacherIcon]] placeholderImage:LOADIMAGE(@"tx-icon")];
            teacherLOne.text     =[model.teacherArray[0] teacherName];
        }
        personNumL.text          =[NSString stringWithFormat:@"已有%ld人报名",(long)model.personNum];
        personNumL.attributedText =[LsMethod changeColorWithStr:personNumL.text RangeStr:[NSString stringWithFormat:@"%ld",(long)model.personNum]];
        
        if ([model.livestatus isEqualToString:@"-1"]) {
            UIImage *image          =LOADIMAGE(@"zhengzaibaoming-icon");
            stausL.image            =image;
        }else if ([model.livestatus isEqualToString:@"0"]){
            UIImage *image          =LOADIMAGE(@"zhengzaizhibo-icon");
            stausL.image            =image;
        }else{
            UIImage *image          =LOADIMAGE(@"hf_icon");
            stausL.image            =image;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
