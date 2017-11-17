//
//  LsPracticeTableViewCell.m
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPracticeTableViewCell.h"

@interface LsPracticeTableViewCell ()
{
    UIView         *line;
    UILabel        *personNum;
    UILabel        *titleL;
    UIImageView    *imageV;
    UILabel        *authorL;
    UILabel        *typeL;
    UIImageView    *commentImageView;
    UILabel        *commentNumL;
    UIView         *baseView;
    
    UIImageView    *recommendImageV;
    UILabel        *uploadDateL;
    UILabel        *authorTypeL;

}
@end

@implementation LsPracticeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 210*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
       
        titleL                  =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 0, LSMainScreenW-40, 35*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:17.5];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:titleL];
        
        UIImage      *ima    =[UIImage imageNamed:@"tj"];
        recommendImageV               =[[UIImageView alloc] init];
        recommendImageV.frame         =CGRectMake(baseView.frame.size.width-ima.size.width, 0, ima.size.width, ima.size.height);
        recommendImageV.image         =ima;
        //        imageV.hidden        =YES;
        [baseView addSubview:recommendImageV];
        
        uploadDateL             =[[UILabel alloc] initWithFrame:CGRectMake(baseView.frame.size.width-CGRectGetWidth(recommendImageV.frame)-70*LSScale, 0, 70*LSScale, 35*LSScale)];
        uploadDateL.font             =[UIFont systemFontOfSize:13*LSScale];
        uploadDateL.textColor        =[UIColor darkTextColor];
        uploadDateL.textAlignment    =NSTextAlignmentCenter;
        [baseView addSubview:uploadDateL];
        
        imageV                  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 35*LSScale, LSMainScreenW, 140*LSScale)];
        [baseView addSubview:imageV];
        
        authorL                 =[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageV.frame), 75, 35*LSScale)];
        authorL.font            =[UIFont systemFontOfSize:15.5];
        authorL.textColor       =[UIColor darkTextColor];
        authorL.textAlignment   =NSTextAlignmentLeft;
        [baseView addSubview:authorL];
        
        typeL                    =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(authorL.frame), CGRectGetMaxY(imageV.frame)+7.5*LSScale, 60, 20*LSScale)];
        typeL.font               =[UIFont systemFontOfSize:15];
        typeL.textColor          =LSNavColor;
        typeL.layer.cornerRadius =10*LSScale;
        typeL.layer.borderWidth  =1;
        typeL.layer.borderColor  =LSNavColor.CGColor;
        typeL.textAlignment      =NSTextAlignmentCenter;
        [baseView addSubview:typeL];
        
        authorTypeL                    =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeL.frame)+10*LSScale, CGRectGetMaxY(imageV.frame)+7.5*LSScale, 60, 20*LSScale)];
        authorTypeL.font               =[UIFont systemFontOfSize:15];
        authorTypeL.textColor          =LSNavColor;
        authorTypeL.layer.cornerRadius =10*LSScale;
        authorTypeL.layer.borderWidth  =1;
        authorTypeL.layer.borderColor  =LSNavColor.CGColor;
        authorTypeL.textAlignment      =NSTextAlignmentCenter;
        [baseView addSubview:authorTypeL];

        
        UIImage *image          =[UIImage imageNamed:@"note_button"];
        commentImageView        =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW-80,CGRectGetMaxY(imageV.frame)+ 10*LSScale, 15*LSScale, 15*LSScale)];
        commentImageView.image  =image;
        [baseView addSubview:commentImageView];

        commentNumL   =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentImageView.frame)+5, CGRectGetMaxY(imageV.frame),50, 35*LSScale)];
        commentNumL.font          =[UIFont systemFontOfSize:15.5];
        commentNumL.textAlignment =NSTextAlignmentLeft;
        commentNumL.textColor     =[UIColor lightGrayColor];
        [baseView addSubview:commentNumL];
        
        personNum               =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, LSMainScreenW,35)];
        personNum.font          =[UIFont systemFontOfSize:14];
        personNum.textAlignment =NSTextAlignmentLeft;
        personNum.textColor     =[UIColor lightGrayColor];
        [baseView addSubview:personNum];
        
        self.button             =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-25, 9, 12, 15)];
        [self.button setBackgroundImage:[UIImage imageNamed:@"sj_button"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:self.button];

        
        line                 =[[UIView alloc] init];
        line.backgroundColor =LSLineColor;
        [baseView addSubview:line];
    }
    return self;
}

-(void)clickBtn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickRightButton)]) {
        [self.delegate didClickRightButton];
    }
}

-(void)reloadCell:(id)model Type:(NSString*)type{
    
    if ([type isEqualToString:@"0"]) {
        LsPracticeModel *modelll =model;
        baseView.frame           =CGRectMake(0, 0, LSMainScreenW, 35);
        line.frame               =CGRectMake(0, 35-0.5, LSMainScreenW, 0.5);
        personNum.text           =[NSString stringWithFormat:@"本周共有%ld位同学获得了名师点评,快去看看吧",(long)modelll.personNum];
        NSString *string =personNum.text;
        NSString *stringForColor = [NSString stringWithFormat:@"%ld",(long)modelll.personNum];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange range = [string rangeOfString:stringForColor];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:LSNavColor range:range];
        personNum.attributedText =mAttStri;
        
        personNum.hidden         =NO;
        self.button.hidden       =NO;

        titleL.hidden            =YES;
        imageV.hidden            =YES;
        authorL.hidden           =YES;
        typeL.hidden             =YES;
        commentImageView.hidden  =YES;
        commentNumL.hidden       =YES;
        
        recommendImageV.hidden   =YES;
        authorTypeL.hidden       =YES;
        uploadDateL.hidden       =YES;
        
    }else{
        LsPracticeListModel *modelll  =model;
        titleL.text                   =modelll.title;
        line.frame                    =CGRectMake(0, 210*LSScale-0.5, LSMainScreenW, 0.5);

        [imageV sd_setImageWithURL:modelll.coverImage placeholderImage:[UIImage imageNamed:@"banner"]];
        
        CGSize size                   = [LsMethod sizeWithString:modelll.author font:authorL.font];
        authorL.frame                 = CGRectMake(authorL.frame.origin.x,authorL.frame.origin.y, size.width,35*LSScale);
        typeL.frame                   =CGRectMake(CGRectGetMaxX(authorL.frame)+12, typeL.frame.origin.y, typeL.frame.size.width, typeL.frame.size.height);
        authorL.text                  =modelll.author;
        typeL.text                    =modelll.classType;
        
        titleL.hidden                 =NO;
        imageV.hidden                 =NO;
        authorL.hidden                =NO;
        typeL.hidden                  =NO;
        commentImageView.hidden       =NO;
        commentNumL.hidden            =NO;
        commentNumL.text              =[NSString stringWithFormat:@"%ld",(long)modelll.commnetNum];
        
        personNum.hidden              =YES;
        self.button.hidden            =YES;
        
        recommendImageV.hidden        =YES;
//        authorTypeL.hidden            =YES;
        uploadDateL.hidden            =YES;
        
        if ([type isEqualToString:@"1"]) {
            if ([LsMethod haveValue:modelll.classType]) {
                if ([modelll.classType isEqualToString:@"SK"]) {
                    modelll.ctag1 =@"说课";
                }else if([modelll.classType isEqualToString:@"SJ"]){
                    modelll.ctag1 =@"试讲";
                }else if([modelll.classType isEqualToString:@"JGH"]){
                    modelll.ctag1 =@"结构化";
                }else if([modelll.classType isEqualToString:@"DB"]){
                    modelll.ctag1 =@"答辩";
                }
            }else{
                modelll.ctag1 =@"全部";
            }
            
            if ([LsMethod haveValue:modelll.authorType]) {
                modelll.ctag2 =modelll.authorType;
            }else{
                modelll.ctag2 =@"神秘人";
            }
        }else if ([type isEqualToString:@"2"]){
            recommendImageV.hidden   =YES;
            authorTypeL.hidden       =NO;
            uploadDateL.hidden       =NO;
            if (modelll.isRecommend) {
                recommendImageV.hidden   =NO;
            }
            line.frame                    =CGRectMake(0,0, LSMainScreenW, 1.5*LSScale);
            line.backgroundColor          =LSNavColor;
            
            NSString  *strDate            =[LsMethod toDateWithTimeStamp:modelll.endDate DateFormat:@"yyyy年MM月dd日"];
            CGSize uploadDateLSize        = [LsMethod sizeWithString:strDate font:uploadDateL.font];
            uploadDateL.text              =strDate;
            uploadDateL.frame             =CGRectMake(uploadDateL.frame.origin.x, uploadDateL.frame.origin.y,uploadDateLSize.width, uploadDateL.frame.size.height);
            
            titleL.frame                  =CGRectMake(titleL.frame.origin.x, titleL.frame.origin.y, CGRectGetMinX(uploadDateL.frame)-titleL.frame.origin.x, titleL.frame.size.height);
            
            CGSize size                   = [LsMethod sizeWithString:modelll.teacher font:authorL.font];
            authorL.frame                 = CGRectMake(authorL.frame.origin.x,authorL.frame.origin.y, size.width,35*LSScale);
            authorL.textColor             =LSNavColor;
          
            
            [imageV sd_setImageWithURL:modelll.videoHeadUrl placeholderImage:[UIImage imageNamed:@"banner"]];
            
            if ([LsMethod haveValue:modelll.ctag1]) {
                if ([modelll.ctag1 isEqualToString:@"SK"]) {
                    modelll.ctag1 =@"说课";
                }else if([modelll.ctag1 isEqualToString:@"SJ"]){
                    modelll.ctag1 =@"试讲";
                }else if([modelll.ctag1 isEqualToString:@"JGH"]){
                    modelll.ctag1 =@"结构化";
                }else if([modelll.ctag1 isEqualToString:@"DB"]){
                    modelll.ctag1 =@"答辩";
                }
            }else{
                modelll.ctag1 =@"全部";
            }
            
            if ([LsMethod haveValue:modelll.ctag2]) {
                if ([modelll.ctag2 isEqualToString:@"STUD"]) {
                    modelll.ctag2 =@"学生";
                }else if([modelll.ctag2 isEqualToString:@"TEACH"]){
                    modelll.ctag2 =@"名师";
                }
            }else{
                modelll.ctag2 =@"神秘人";
            }
            
            
            titleL.text                   =modelll.title;
            authorL.text                  =modelll.teacher;
            commentNumL.text              =[NSString stringWithFormat:@"%ld",(long)modelll.commnetNum];
            }
        typeL.frame                   =CGRectMake(CGRectGetMaxX(authorL.frame)+12, typeL.frame.origin.y, typeL.frame.size.width, typeL.frame.size.height);
        authorTypeL.frame         =CGRectMake(CGRectGetMaxX(typeL.frame)+12, authorTypeL.frame.origin.y, authorTypeL.frame.size.width, authorTypeL.frame.size.height);
        typeL.text                    =modelll.ctag1;
        authorTypeL.text              =modelll.ctag2;
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
