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
    UIImageView       *teaTwoIV ;
    UILabel           *teacherLTwo;
    UILabel           *personNumL;
    UILabel           *stausL;
    UIImageView       *timeIV;
    
    UIImageView       *noDataImageView;
    UILabel           *noDataL;
    UIView            *baseView ;
    UIView            *line;
    UIImageView       *imageV;
    LsButton          *intoBtn;
    LsButton          *evaluateBtn;
    
    UIView            *topLine;
}

@end

@implementation LsMyLiveListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 125*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
        topLine          =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 1.5*LSScale)];
        topLine.backgroundColor  =LSNavColor;
        topLine.hidden           =YES;
        [baseView addSubview:topLine];
        
        titleL        =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 8*LSScale, LSMainScreenW-40, 25*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:17.5];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:titleL];
        
        //        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
        timeIV    =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale,CGRectGetMaxY(titleL.frame)+5*LSScale,15*LSScale, 15*LSScale)];
        [baseView addSubview:timeIV];
        
        timeL         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIV.frame)+10,CGRectGetMidY(timeIV.frame)-10*LSScale, LSMainScreenW-timeL.frame.origin.x, 20*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:16];
        timeL.textColor         =LSColor(153, 153, 153, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:timeL];
        
        teaOneIV  =[[UIImageView alloc] initWithFrame:CGRectMake(17*LSScale, CGRectGetMaxY(timeL.frame)+10*LSScale, 30*LSScale, 30*LSScale)];
        teaOneIV.layer.cornerRadius       =15*LSScale;
        teaOneIV.layer.masksToBounds      =YES;
        [baseView addSubview:teaOneIV];
        
        teacherLOne    =[[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMidX(teaOneIV.frame)-22.5*LSScale, CGRectGetMaxY(teaOneIV.frame), 45*LSScale, 20*LSScale)];
        teacherLOne.font            =[UIFont systemFontOfSize:14];
        teacherLOne.textAlignment   =NSTextAlignmentCenter;
        teacherLOne.textColor       =LSColor(153, 153, 153, 1);
        [baseView addSubview:teacherLOne];
        
        teaTwoIV  =[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(teaOneIV.frame)+20*LSScale, CGRectGetMaxY(timeL.frame)+10*LSScale, 30*LSScale, 30*LSScale)];
        teaTwoIV.layer.cornerRadius       =15*LSScale;
        teaTwoIV.layer.masksToBounds      =YES;
        [baseView addSubview:teaTwoIV];
        
        teacherLTwo    =[[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMidX(teaTwoIV.frame)-22.5*LSScale, CGRectGetMaxY(teaTwoIV.frame), 45*LSScale, 20*LSScale)];
        teacherLTwo.font            =[UIFont systemFontOfSize:14];
        teacherLTwo.textAlignment   =NSTextAlignmentCenter;
        teacherLTwo.textColor       =LSColor(153, 153, 153, 1);
        [baseView addSubview:teacherLTwo];
        
        personNumL   =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW-200,CGRectGetMinY(teacherLOne.frame) , 190, 20*LSScale)];
        personNumL.textAlignment =NSTextAlignmentRight;
        personNumL.textColor     =LSColor(153, 153, 153, 1);
        personNumL.font          =[UIFont systemFontOfSize:14];
        [baseView addSubview:personNumL];
        
        stausL       =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW-100, CGRectGetMinY(personNumL.frame)-20*LSScale, 90, 20*LSScale)];
        stausL.textColor       =LSColor(255, 90, 122, 1);
        stausL.font            =[UIFont systemFontOfSize:15.5];
        stausL.textAlignment   =NSTextAlignmentRight;
        [baseView addSubview:stausL];
        
        UIImage  *iamge        =[UIImage imageNamed:@"kym_icon"];
        noDataImageView        =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW/2-iamge.size.width/2, 15*LSScale, iamge.size.width, iamge.size.height)];
        [baseView addSubview:noDataImageView];
        
        noDataL                =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noDataImageView.frame)+5, LSMainScreenW, 25*LSScale)];
        noDataL.textAlignment  =NSTextAlignmentCenter;
        noDataL.font           =[UIFont systemFontOfSize:15];
        noDataL.textColor      =[UIColor darkTextColor];
        [baseView addSubview:noDataL];
        
        line           =[[UIView alloc] initWithFrame:CGRectMake(0, 125*LSScale-0.5, LSMainScreenW, 0.5)];
        line.backgroundColor   =LSLineColor;
        [baseView addSubview:line];
        
        UIImage      *ima    =[UIImage imageNamed:@"tj"];
        imageV               =[[UIImageView alloc] init];
        imageV.frame         =CGRectMake(baseView.frame.size.width-ima.size.width, 0, ima.size.width, ima.size.height);
        imageV.image         =ima;
        imageV.hidden        =YES;
        [baseView addSubview:imageV];
        
        intoBtn              =[[LsButton alloc] init];
        [intoBtn setTitleColor:[UIColor whiteColor] forState:0];
        intoBtn.layer.cornerRadius    =12.5*LSScale;
        intoBtn.layer.backgroundColor =LSNavColor.CGColor;
        intoBtn.titleLabel.font       =[UIFont systemFontOfSize:15];
        [intoBtn addTarget:self action:@selector(clickIntoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:intoBtn];
        
        evaluateBtn              =[[LsButton alloc] init];
        [evaluateBtn setTitleColor:[UIColor whiteColor] forState:0];
        evaluateBtn.layer.cornerRadius    =12.5*LSScale;
        evaluateBtn.layer.backgroundColor =LSNavColor.CGColor;
        evaluateBtn.titleLabel.font       =[UIFont systemFontOfSize:15];
        [evaluateBtn addTarget:self action:@selector(clickEvaluateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:evaluateBtn];
    }
    return self;
}

-(void)clickEvaluateBtn:(LsButton *)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickEvaluateBtnIndex:)]) {
        [self.delegate didClickEvaluateBtnIndex:button];
    }
}

-(void)clickIntoBtn:(LsButton*)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickIntoBtn:isPackage:)]) {
        [self.delegate didClickIntoBtn:button isPackage:button.isPackage];
    }
}

-(void)reloadCell:(LsMyLiveModel*)model Type:(NSString*)type{
    if ([type isEqualToString:@"0"])//无数据
    {
        noDataImageView.hidden   =NO;
        noDataL.hidden           =NO;
        UIImage  *iamge          =[UIImage imageNamed:@"kym_icon"];
        noDataImageView.image    =iamge;
        noDataL.text             =@"暂时没有直播,快去看看回放吧~";
    }else{
        noDataImageView.hidden  =YES;
        noDataL.hidden          =YES;
        titleL.text             =model.name;
        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
        timeIV.image            =image;
        
        NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDay DateFormat:@"yyyy-MM-dd"];
        NSString *endDate   =[LsMethod toDateWithTimeStamp:model.endDay   DateFormat:@"yyyy-MM-dd"];
        timeL.text  =[NSString stringWithFormat:@"%@-%@",startDate,endDate];
        
        if (model.teachers.count>0) {
            [teaOneIV sd_setImageWithURL:[model.teachers[0] idCardUrl] placeholderImage:[UIImage imageNamed:@"zhibo"]];
            teacherLOne.text     =[model.teachers[0] name];
            if (model.teachers.count>1) {
                [teaTwoIV sd_setImageWithURL:[model.teachers[1] idCardUrl] placeholderImage:[UIImage imageNamed:@"zhibo"]];
                teacherLTwo.text =[model.teachers[1] name];
            }
        }
        personNumL.text          =[NSString stringWithFormat:@"已有%@人报名",model.ratenum];
        stausL.text              =@"正在报名";
        
        if ([type isEqualToString:@"1"])// 今日直播 正在直播
        {
            personNumL.hidden =YES;
            stausL.hidden     =NO;
            intoBtn.frame     =CGRectMake(baseView.frame.size.width-10*LSScale-100*LSScale, CGRectGetMaxY(teacherLOne.frame)-25*LSScale, 100*LSScale, 25*LSScale);
            [intoBtn setTitle:@"进入直播间" forState:0];
            intoBtn.videoID   = model.courseCode;
            stausL.frame      =CGRectMake(CGRectGetMinX(intoBtn.frame)-10-80*LSScale, CGRectGetMinY(intoBtn.frame), 80*LSScale, 25*LSScale);
            stausL.layer.cornerRadius =12.5*LSScale;
            stausL.layer.backgroundColor =LSNavColor.CGColor;
            stausL.font       =[UIFont systemFontOfSize:15];
            stausL.text       =@"今日直播";
            stausL.textColor  =[UIColor whiteColor];
            stausL.textAlignment =NSTextAlignmentCenter;
            
        }else if ([type isEqualToString:@"2"])// 未开始
        {
            personNumL.hidden =YES;
            stausL.hidden=YES;
            intoBtn.frame     =CGRectMake(baseView.frame.size.width-10*LSScale-100*LSScale, CGRectGetMaxY(teacherLOne.frame)-25*LSScale, 100*LSScale, 25*LSScale);
            [intoBtn setTitle:@"进入直播间" forState:0];
            intoBtn.videoID   = model.courseCode;

        }else if ([type isEqualToString:@"3"])//可回放
        {
//            personNumL.hidden =YES;
            stausL.hidden=YES;
            personNumL.text   =[NSString stringWithFormat:@"共有%@人评价了该直播",model.ratenum];
            NSString *string =personNumL.text;
            NSString *stringForColor = [NSString stringWithFormat:@"%@",model.ratenum];
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            NSRange range = [string rangeOfString:stringForColor];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:LSNavColor range:range];
            personNumL.attributedText =mAttStri;
            
            evaluateBtn.frame         =CGRectMake(baseView.frame.size.width-10*LSScale-70*LSScale, CGRectGetMinY(personNumL.frame)-30*LSScale, 70*LSScale, 25*LSScale);
            [evaluateBtn setTitle:@"去评价" forState:0];
            evaluateBtn.videoID       =model.courseCode ;
            evaluateBtn.title         =model.name;
            evaluateBtn.layer.backgroundColor =LSNavColor.CGColor;
            
            if (model.myrate) {
                [evaluateBtn setTitle:@"已评价" forState:0];
                evaluateBtn.layer.backgroundColor =LSColor(169, 170, 171, 1).CGColor;
            }
            intoBtn.frame     =CGRectMake(CGRectGetMinX(evaluateBtn.frame)-10-80*LSScale, CGRectGetMinY(personNumL.frame)-30*LSScale, 80*LSScale, 25*LSScale);
            [intoBtn setTitle:@"查看回放" forState:0];
            [intoBtn setTitleColor:[UIColor darkGrayColor] forState:0];
            intoBtn.layer.backgroundColor  =[UIColor whiteColor].CGColor;
            intoBtn.layer.borderWidth=1;
            intoBtn.layer.borderColor=[UIColor darkGrayColor].CGColor;
            intoBtn.videoID   = model.courseCode;
        }
    }
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