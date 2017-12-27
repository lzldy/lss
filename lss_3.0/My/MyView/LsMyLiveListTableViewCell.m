//
//  LsMyLiveListTableViewCell.m
//  lss
//
//  Created by apple on 2017/11/29.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyLiveListTableViewCell.h"

@interface LsMyLiveListTableViewCell ()
{
    UILabel           *titleL;
    UILabel           *timeL;
    UIImageView       *teaOneIV ;
    UILabel           *teacherLOne;
    UILabel           *personNumL;
//    UIImageView       *stausL;
    UIImageView       *timeIV;
    
    UIImageView       *noDataImageView;
    UILabel           *noDataL;
    UIView            *baseView ;
    UIView            *line;
    UIImageView       *imageV;
    
    UIView            *midLine;
    LsButton          *evaluateBtn;
}

@end

@implementation LsMyLiveListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0*LSScale, LSMainScreenW, 100*LSScale)];
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
        
        titleL        =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(timeL.frame)+5*LSScale, LSMainScreenW-100*LSScale, 30*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:14];
        titleL.textColor        =LSColor(86, 85, 85, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        titleL.numberOfLines    =0;
        [baseView addSubview:titleL];
        
        midLine    =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+4.5*LSScale, LSMainScreenW, 0.5)];
        midLine.backgroundColor  =LSLineColor;
        [baseView addSubview:midLine];
        
        evaluateBtn       =[[LsButton alloc] initWithFrame:CGRectMake(LSMainScreenW-50*LSScale-15*LSScale, CGRectGetMinY(midLine.frame)-12*LSScale-20*LSScale, 50*LSScale, 20*LSScale)];
        [evaluateBtn addTarget:self action:@selector(clickEvaluateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:evaluateBtn];
        
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
        
        line           =[[UIView alloc] initWithFrame:CGRectMake(0, 100*LSScale-0.5, LSMainScreenW, 0.5)];
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

-(void)clickEvaluateBtn:(LsButton *)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickEvaluateBtnIndex:)]) {
        [self.delegate didClickEvaluateBtnIndex:button];
    }
}

-(void)reloadCell:(LsMyLiveModel*)model Type:(NSString*)type{
    midLine.hidden              =YES;
    if ([type isEqualToString:@"0"])//无数据
    {
        noDataImageView.hidden   =NO;
        noDataL.hidden           =NO;
        UIImage  *iamge          =LOADIMAGE(@"kym_icon");
        noDataImageView.image    =iamge;
        noDataL.text             =@"暂时没有直播,快去看看回放吧~";
    }else{
        noDataImageView.hidden  =YES;
        noDataL.hidden          =YES;
        imageV.hidden           =YES;
        titleL.text             =model.name;
        UIImage      *image     =LOADIMAGE(@"time_icon");
        timeIV.image            =image;
        
        NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDay DateFormat:@"yyyy.MM.dd"];
//        NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDay   DateFormat:@"yyyy.MM.dd"];
//        NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
//        if (model.isPackage) {
//            startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy.MM.dd"];
//            endDate   =[LsMethod toDateWithTimeStamp:model.endDate   DateFormat:@"yyyy.MM.dd"];
//            timeL.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
//        }else{
//            timeL.text  =[NSString stringWithFormat:@"%@  %@开始",startDate,startTime];
//        }
        timeL.text  =[NSString stringWithFormat:@"%@ 开始",startDate];

        
//        UIImage      *ima    =LOADIMAGE(@"tuijian-icon");
//        imageV.frame         =CGRectMake(CGRectGetMaxX(timeL.frame)+5, CGRectGetMidY(timeL.frame)-ima.size.height/2, ima.size.width, ima.size.height);
//        if (model.isRecommend) {
//            imageV.hidden=NO;
//        }
        
        teaOneIV.image  =LOADIMAGE(@"tx-icon");
        if (model.teachers.count>0) {
            [teaOneIV sd_setImageWithURL:[model.teachers[0] idCardUrl] placeholderImage:LOADIMAGE(@"tx-icon")];
            teacherLOne.text     =[model.teachers[0] name];
        }
        personNumL.text          =[NSString stringWithFormat:@"已有%@人报名",model.ratenum];
        personNumL.attributedText =[LsMethod changeColorWithStr:personNumL.text RangeStr:model.ratenum];
        
        if ([type isEqualToString:@"3"]) {
            midLine.hidden             =NO;
            if (model.myrate) {
                [evaluateBtn setImage:LOADIMAGE(@"ypj_icon") forState:0];
                evaluateBtn.userInteractionEnabled =NO;
            }else{
                [evaluateBtn setImage:LOADIMAGE(@"qpj_icon") forState:0];
                evaluateBtn.userInteractionEnabled =YES;
                evaluateBtn.videoID       =model.crid ;
                evaluateBtn.title         =model.name;
                evaluateBtn.isEvaluate    =YES;
            }
        }else{
            personNumL.hidden   =YES;
            UIImage  *image     =LOADIMAGE(@"zbj_icon");
            evaluateBtn.frame   =CGRectMake(LSMainScreenW-15*LSScale-image.size.width,45*LSScale-image.size.height/2, image.size.width, image.size.height);
            [evaluateBtn setImage:image forState:0];
            evaluateBtn.videoID   = model.courseCode;
            evaluateBtn.num       = [model.baseNum intValue]+[model.regNum intValue];
        }
    }
}


//-(void)reloadCell:(LsMyLiveModel*)model Type:(NSString*)type{
//    if ([type isEqualToString:@"0"])//无数据
//    {
//        noDataImageView.hidden   =NO;
//        noDataL.hidden           =NO;
//        UIImage  *iamge          =[UIImage imageNamed:@"kym_icon"];
//        noDataImageView.image    =iamge;
//        noDataL.text             =@"暂时没有直播,快去看看回放吧~";
//    }else{
//        noDataImageView.hidden  =YES;
//        noDataL.hidden          =YES;
//        titleL.text             =model.name;
//        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
//        timeIV.image            =image;
//
//        NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDay DateFormat:@"yyyy-MM-dd"];
//        NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDay   DateFormat:@"yyyy-MM-dd"];
//        timeL.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
//
//        if (model.teachers.count>0) {
//            [teaOneIV sd_setImageWithURL:[model.teachers[0] idCardUrl] placeholderImage:[UIImage imageNamed:@"zhibo"]];
//            teacherLOne.text     =[model.teachers[0] name];
//            if (model.teachers.count>1) {
//                [teaTwoIV sd_setImageWithURL:[model.teachers[1] idCardUrl] placeholderImage:[UIImage imageNamed:@"zhibo"]];
//                teacherLTwo.text =[model.teachers[1] name];
//            }
//        }
//        personNumL.text          =[NSString stringWithFormat:@"已有%@人报名",model.ratenum];
//        stausL.text              =@"正在报名";
//
//        if ([type isEqualToString:@"1"])// 今日直播 正在直播
//        {
//            personNumL.hidden =YES;
//            stausL.hidden     =NO;
//            intoBtn.frame     =CGRectMake(baseView.frame.size.width-10*LSScale-100*LSScale, CGRectGetMaxY(teacherLOne.frame)-25*LSScale, 100*LSScale, 25*LSScale);
//            [intoBtn setTitle:@"进入直播间" forState:0];
//            intoBtn.videoID   = model.courseCode;
//            intoBtn.num       = [model.baseNum intValue]+[model.regNum intValue];
//
//            stausL.frame      =CGRectMake(CGRectGetMinX(intoBtn.frame)-10-80*LSScale, CGRectGetMinY(intoBtn.frame), 80*LSScale, 25*LSScale);
//            stausL.layer.cornerRadius =12.5*LSScale;
//            stausL.layer.backgroundColor =LSNavColor.CGColor;
//            stausL.font       =[UIFont systemFontOfSize:15];
//            stausL.text       =@"今日直播";
//            stausL.textColor  =[UIColor whiteColor];
//            stausL.textAlignment =NSTextAlignmentCenter;
//
//        }else if ([type isEqualToString:@"2"])// 未开始
//        {
//            personNumL.hidden =YES;
//            stausL.hidden=YES;
//            intoBtn.frame     =CGRectMake(baseView.frame.size.width-10*LSScale-100*LSScale, CGRectGetMaxY(teacherLOne.frame)-25*LSScale, 100*LSScale, 25*LSScale);
//            [intoBtn setTitle:@"进入直播间" forState:0];
//            intoBtn.videoID   = model.courseCode;
//            intoBtn.num       = [model.baseNum intValue]+[model.regNum intValue];
//
//        }else if ([type isEqualToString:@"3"])//可回放
//        {
////            personNumL.hidden =YES;
//            stausL.hidden=YES;
//            personNumL.text   =[NSString stringWithFormat:@"共有%@人评价了该直播",model.ratenum];
//            NSString *string =personNumL.text;
//            NSString *stringForColor = [NSString stringWithFormat:@"%@",model.ratenum];
//            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
//            NSRange range = [string rangeOfString:stringForColor];
//            [mAttStri addAttribute:NSForegroundColorAttributeName value:LSNavColor range:range];
//            personNumL.attributedText =mAttStri;
//
//            evaluateBtn.frame         =CGRectMake(baseView.frame.size.width-10*LSScale-70*LSScale, CGRectGetMinY(personNumL.frame)-30*LSScale, 70*LSScale, 25*LSScale);
//            [evaluateBtn setTitle:@"去评价" forState:0];
//            evaluateBtn.videoID       =model.crid ;
//            evaluateBtn.title         =model.name;
//            evaluateBtn.layer.backgroundColor =LSNavColor.CGColor;
//
//            if (model.myrate) {
//                [evaluateBtn setTitle:@"已评价" forState:0];
//                evaluateBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
//            }
//            intoBtn.frame     =CGRectMake(CGRectGetMinX(evaluateBtn.frame)-10-80*LSScale, CGRectGetMinY(personNumL.frame)-30*LSScale, 80*LSScale, 25*LSScale);
//            [intoBtn setTitle:@"查看回放" forState:0];
//            [intoBtn setTitleColor:[UIColor darkGrayColor] forState:0];
//            intoBtn.layer.backgroundColor  =[UIColor whiteColor].CGColor;
//            intoBtn.layer.borderWidth=1;
//            intoBtn.layer.borderColor=[UIColor darkGrayColor].CGColor;
//            intoBtn.videoID   = model.courseCode;
//            intoBtn.num       = [model.baseNum intValue]+[model.regNum intValue];
//        }
//    }
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
