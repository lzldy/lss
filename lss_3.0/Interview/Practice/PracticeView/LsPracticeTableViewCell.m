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

}
@end

@implementation LsPracticeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  =[UIColor whiteColor];
        
        titleL                  =[[UILabel alloc] initWithFrame:CGRectMake(20, 0, LSMainScreenW-40, 35*LSScale)];
        //        titleL.font             =[UIFont fontWithName:@"Helvetica-Bold" size:14];
        titleL.font             =[UIFont systemFontOfSize:14];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [self addSubview:titleL];
        
        imageV                  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 35*LSScale, LSMainScreenW, 125*LSScale)];
        [self addSubview:imageV];
        
        authorL                 =[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageV.frame), 75, 35*LSScale)];
        authorL.font            =[UIFont systemFontOfSize:12.5];
        authorL.textColor       =[UIColor darkTextColor];
        authorL.textAlignment   =NSTextAlignmentLeft;
        [self addSubview:authorL];
        
        typeL                    =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(authorL.frame), CGRectGetMaxY(imageV.frame)+7.5*LSScale, 60, 20*LSScale)];
        typeL.font               =[UIFont systemFontOfSize:12.5];
        typeL.textColor          =LSNavColor;
        typeL.layer.cornerRadius =10*LSScale;
        typeL.layer.borderWidth  =1;
        typeL.layer.borderColor  =LSNavColor.CGColor;
        typeL.textAlignment      =NSTextAlignmentCenter;
        [self addSubview:typeL];
        
        UIImage *image          =[UIImage imageNamed:@"note_button"];
        commentImageView        =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW-60,CGRectGetMaxY(imageV.frame)+ 35*LSScale/2-image.size.height/2, image.size.width, image.size.height)];
        commentImageView.image  =image;
        [self addSubview:commentImageView];

        commentNumL   =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentImageView.frame)+5, CGRectGetMaxY(imageV.frame),45, 35*LSScale)];
        commentNumL.font          =[UIFont systemFontOfSize:12];
        commentNumL.textAlignment =NSTextAlignmentLeft;
        commentNumL.textColor     =[UIColor lightGrayColor];
        [self addSubview:commentNumL];
        
        personNum               =[[UILabel alloc] initWithFrame:CGRectMake(20, 0, LSMainScreenW, 30*LSScale)];
        personNum.font          =[UIFont systemFontOfSize:12];
        personNum.textAlignment =NSTextAlignmentLeft;
        personNum.textColor     =[UIColor lightGrayColor];
        [self addSubview:personNum];
        
        self.button          =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-40, 0, 40, 30*LSScale)];
        [self.button setImage:[UIImage imageNamed:@"sj_button"] forState:UIControlStateNormal];
        [self addSubview:self.button];
        
        line                 =[[UIView alloc] init];
        line.backgroundColor =LSColor(243, 244, 245, 1);
        [self addSubview:line];
    }
    return self;
}



-(void)reloadCell:(id)model Type:(NSString*)type{
    
    if ([type isEqualToString:@"0"]) {
        LsPracticeModel *modelll =model;
        line.frame               =CGRectMake(0, 30*LSScale-0.5, LSMainScreenW, 0.5);
        personNum.hidden         =NO;
        personNum.text           =[NSString stringWithFormat:@"本周共有%ld位同学获得了名师点评,快去看看吧",(long)modelll.personNum];
        commentImageView.hidden  =YES;
        commentNumL.hidden       =YES;
        self.button.hidden       =NO;
        
    }else if([type isEqualToString:@"1"]){
        LsPracticeListModel *modelll  =model;
        personNum.hidden              =YES;
        line.frame                    =CGRectMake(0, 195*LSScale-0.5, LSMainScreenW, 0.5);
        titleL.text                   =modelll.title;
        [imageV sd_setImageWithURL:modelll.coverImage placeholderImage:nil];
        
        CGSize size           = [LsMethod sizeWithString:modelll.author font:authorL.font];
        authorL.frame         = CGRectMake(authorL.frame.origin.x,authorL.frame.origin.y, size.width,35*LSScale);
        typeL.frame           =CGRectMake(CGRectGetMaxX(authorL.frame)+12, typeL.frame.origin.y, typeL.frame.size.width, typeL.frame.size.height);
        authorL.text                  =modelll.author;
        typeL.text                    =modelll.classType;
        
        commentImageView.hidden       =NO;
        commentNumL.hidden            =NO;
        commentNumL.text              =[NSString stringWithFormat:@"%ld",(long)modelll.commnetNum];
        
        self.button.hidden            =YES;
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
