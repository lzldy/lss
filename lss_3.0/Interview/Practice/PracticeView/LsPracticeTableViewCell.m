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
    UIImageView    *imageV;
    UIView         *baseView;
    UILabel        *titleL;
    UILabel        *authorL;
    UILabel        *typeL;
    UILabel        *authorTypeL;

    UIImageView    *commentImageView;//评论
    UILabel        *commentNumL;
    UIImageView    *playImageView;
//    UIImageView    *recommendImageV;//推荐

}
@end

@implementation LsPracticeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 10*LSScale, LSMainScreenW, 270*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
       
        imageV                  =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale, 13.5*LSScale, LSMainScreenW-20*LSScale, 200*LSScale)];
        [baseView addSubview:imageV];
        
        titleL                  =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(imageV.frame)+10*LSScale, LSMainScreenW-20*LSScale, 15*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:15*LSScale];
        titleL.textColor        =LSColor(86, 85, 85, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:titleL];
        
        authorL                 =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(titleL.frame)+10*LSScale, 75, 15*LSScale)];
        authorL.font            =[UIFont systemFontOfSize:14*LSScale];
        authorL.textColor       =LSColor(115, 114, 114, 1);
        authorL.textAlignment   =NSTextAlignmentLeft;
//        authorL.backgroundColor =[UIColor redColor];
        [baseView addSubview:authorL];
        
        typeL                    =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(authorL.frame),CGRectGetMaxY(titleL.frame)+10*LSScale, 60, 15*LSScale)];
        typeL.font               =[UIFont systemFontOfSize:13];
        typeL.textColor          =LSNavColor;
        typeL.layer.cornerRadius =5*LSScale;
        typeL.layer.borderWidth  =1;
        typeL.layer.borderColor  =LSNavColor.CGColor;
        typeL.textAlignment      =NSTextAlignmentCenter;
        [baseView addSubview:typeL];
        
        authorTypeL                    =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeL.frame)+10*LSScale, CGRectGetMaxY(titleL.frame)+10*LSScale, 60, 15*LSScale)];
        authorTypeL.font               =[UIFont systemFontOfSize:13];
        authorTypeL.textColor          =LSNavColor;
        authorTypeL.layer.cornerRadius =5*LSScale;
        authorTypeL.layer.borderWidth  =1;
        authorTypeL.layer.borderColor  =LSNavColor.CGColor;
        authorTypeL.textAlignment      =NSTextAlignmentCenter;
        [baseView addSubview:authorTypeL];
        
        UIImage *image          =[UIImage imageNamed:@"pl_icon"];
        commentImageView        =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW-30*LSScale-15*LSScale,CGRectGetMinY(authorL.frame)+1.5, 15*LSScale, 15*LSScale)];
        commentImageView.image  =image;
        commentImageView.contentMode=UIViewContentModeScaleAspectFit;
        [baseView addSubview:commentImageView];
        
        commentNumL   =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentImageView.frame)+5, CGRectGetMinY(authorL.frame),50, 15*LSScale)];
        commentNumL.font          =[UIFont systemFontOfSize:15.5];
        commentNumL.textAlignment =NSTextAlignmentLeft;
        commentNumL.textColor     =LSNavColor;
        [baseView addSubview:commentNumL];
        
        UIImage      *playImage    =[UIImage imageNamed:@"big_stop_ic"];
        playImageView              =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, playImage.size.width, playImage.size.height)];
        playImageView.center       =imageV.center;
        playImageView.image        =playImage;
        [baseView addSubview:playImageView];
    }
    return self;
}

-(void)reloadCell:(id)model Type:(NSString*)type{
    LsPracticeListModel *modelll  =model;
    imageV.image                  =LOADIMAGE(@"tu-icon");
    if ([LsMethod haveValue:modelll.coverImage2]) {
        [imageV sd_setImageWithURL:modelll.coverImage2 placeholderImage:LOADIMAGE(@"tu-icon")];
    }else if([LsMethod haveValue:modelll.videoHeadUrl2]){
        [imageV sd_setImageWithURL:modelll.videoHeadUrl2 placeholderImage:LOADIMAGE(@"tu-icon")];
    }
    titleL.text                   =modelll.title;

    if ([LsMethod haveValue:modelll.author]) {
        authorL.text                  =modelll.author;
    }else if ([LsMethod haveValue:modelll.teacher]){
        authorL.text                  =modelll.teacher;
    }
    authorL.text                 =[LsMethod numberSuitScanf:authorL.text];

    CGSize authorSize             = [LsMethod sizeWithString:authorL.text font:authorL.font];
    authorL.frame                 = CGRectMake(authorL.frame.origin.x,authorL.frame.origin.y, authorSize.width,15*LSScale);
   
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
    }else if ([LsMethod haveValue:modelll.ctag1]) {
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
    CGSize typeSize               = [LsMethod sizeWithString:modelll.ctag1 font:typeL.font];
    if ([LsMethod haveValue:authorL.text]) {
        typeL.frame                   =CGRectMake(CGRectGetMaxX(authorL.frame)+12, typeL.frame.origin.y, typeSize.width*1.5, typeL.frame.size.height);
    }else{
        typeL.frame                   =CGRectMake(CGRectGetMaxX(authorL.frame), typeL.frame.origin.y, typeSize.width*1.5, typeL.frame.size.height);
    }
    typeL.text                    =modelll.ctag1;

    if ([LsMethod haveValue:modelll.authorType]) {
        modelll.ctag2 =modelll.authorType;
    }else if([LsMethod haveValue:modelll.ctag2]) {
        if ([modelll.ctag2 isEqualToString:@"STUD"]) {
            modelll.ctag2 =@"学生";
        }else if([modelll.ctag2 isEqualToString:@"TEACH"]){
            modelll.ctag2 =@"名师";
        }
    }else{
        modelll.ctag2 =@"神秘人";
    }
    CGSize authorTypeSize        = [LsMethod sizeWithString:modelll.ctag2 font:authorTypeL.font];
    authorTypeL.frame            =CGRectMake(CGRectGetMaxX(typeL.frame)+12, authorTypeL.frame.origin.y, authorTypeSize.width*1.5, authorTypeL.frame.size.height);
    authorTypeL.text             =modelll.ctag2;
    
    commentNumL.text             =[NSString stringWithFormat:@"%ld",(long)modelll.commentNum];
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
