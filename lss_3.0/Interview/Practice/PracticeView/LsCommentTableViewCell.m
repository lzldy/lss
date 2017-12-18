//
//  LsCommentTableViewCell.m
//  lss
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCommentTableViewCell.h"

@interface LsCommentTableViewCell ()
{
    UIImageView *iconView;
    UILabel     *nameL;
    UILabel     *timeL;
    UILabel     *commentL;
    UIView      *line;
    UIView      *baseView;
    LsButton    *replyBtn;
}
@end

@implementation LsCommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor            =[UIColor clearColor];
        
        baseView                        =[[UIView alloc] init];
        baseView.backgroundColor        =[UIColor whiteColor];
        [self addSubview:baseView];
        
        iconView                        =[[UIImageView alloc] initWithFrame:CGRectMake(10*LSScale, 10*LSScale,50*LSScale,50*LSScale)];
        iconView.layer.cornerRadius     =25*LSScale;
        iconView.layer.masksToBounds    =YES;
        [baseView addSubview:iconView];

        
        nameL                  =[[UILabel alloc] initWithFrame:CGRectMake(5*LSScale+CGRectGetMaxX(iconView.frame), CGRectGetMinY(iconView.frame),150*LSScale, 25*LSScale)];
        nameL.font             =[UIFont systemFontOfSize:14*LSScale];
        nameL.textColor        =[UIColor darkTextColor];
        nameL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:nameL];
        
        
        timeL             =[[UILabel alloc] initWithFrame:CGRectMake(LSMainScreenW-10*LSScale-80*LSScale, CGRectGetMinY(nameL.frame), 80*LSScale, 25*LSScale)];
        timeL.font             =[UIFont systemFontOfSize:13*LSScale];
        timeL.textColor        =[UIColor darkGrayColor];
        timeL.textAlignment    =NSTextAlignmentCenter;
        [baseView addSubview:timeL];
        
        
        commentL                 =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameL.frame), CGRectGetMaxY(nameL.frame), LSMainScreenW-CGRectGetMinX(nameL.frame)-10*LSScale, 35*LSScale)];
        commentL.font            =[UIFont systemFontOfSize:13*LSScale];
        commentL.textColor       =[UIColor darkGrayColor];
        commentL.textAlignment   =NSTextAlignmentLeft;
        commentL.numberOfLines   =0;
        [baseView addSubview:commentL];
        
        replyBtn             =[[LsButton alloc] init];
        [replyBtn setTitle:@"回复老师" forState:0];
        [replyBtn setTitleColor:LSNavColor forState:0];
        replyBtn.titleLabel.font =[UIFont systemFontOfSize:14.5*LSScale];
        [replyBtn addTarget:self action:@selector(didClickReplyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:replyBtn];
        
        line                 =[[UIView alloc] init];
        line.backgroundColor =LSLineColor;
        [baseView addSubview:line];
    }
    return self;
}

-(void)didClickReplyBtn:(LsButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyComment:)]) {
        [self.delegate replyComment:button];
    }
}

-(void)reloadCellWithData:(LsPracticeCommentModel*)data type:(NSString*)type{
    LsPracticeCommentModel *model =data;
    if ([LsMethod haveValue:model.fromUserName]) {
        nameL.text            =[NSString stringWithFormat:@"%@的点评",model.fromUserName];
    }else{
        nameL.text            =@"唐僧的点评";
    }
    NSString *date        =[LsMethod toDateWithTimeStamp:model.createTimeInSec DateFormat:@"yyyy-MM-dd"];
    timeL.text            =date;
    commentL.text         =model.content;
    [iconView sd_setImageWithURL:model.fromUserHeadUrl placeholderImage:LOADIMAGE(@"touxiang_icon")];
    CGSize  size          =[LsMethod sizeWithSize:CGSizeMake(commentL.frame.size.width, 8000) String:commentL.text font:commentL.font];
    commentL.frame        =CGRectMake(commentL.frame.origin.x, commentL.frame.origin.y, commentL.frame.size.width, size.height);
    line.frame            =CGRectMake(0, CGRectGetMaxY(commentL.frame)+10*LSScale, LSMainScreenW, 0.5);
    baseView.frame        =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
    
    replyBtn.hidden=YES;
    
    if ([type isEqualToString:@"0"]) {
        if (baseView.frame.size.height<70*LSScale) {
            line.frame            =CGRectMake(0, CGRectGetMaxY(iconView.frame)+10*LSScale, LSMainScreenW, 0.5);
            baseView.frame        =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
        }
        self.frame                =baseView.frame;
    }else if ([type isEqualToString:@"T"]){
        replyBtn.hidden   =NO;
        replyBtn.ID       =model.ID;
        replyBtn.frame    =CGRectMake(LSMainScreenW-10*LSScale-65*LSScale, CGRectGetMaxY(commentL.frame)+10*LSScale, 65*LSScale, 25*LSScale);
        line.frame        =CGRectMake(0, CGRectGetMaxY(replyBtn.frame)+10*LSScale, LSMainScreenW, 0.5);
        baseView.frame    =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
        self.frame        =CGRectMake(0, 0, LSMainScreenW,  CGRectGetMaxY(line.frame));
    }else if ([type isEqualToString:@"U"]){
//        replyBtn.ID       =model.ID;
//        replyBtn.frame    =CGRectMake(LSMainScreenW-10*LSScale-65*LSScale, CGRectGetMaxY(commentL.frame)+10*LSScale, 65*LSScale, 25*LSScale);
//        line.frame        =CGRectMake(0, CGRectGetMaxY(replyBtn.frame)+10*LSScale, LSMainScreenW, 0.5);
//        baseView.frame    =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
//        self.frame        =CGRectMake(0, 0, LSMainScreenW,  CGRectGetMaxY(line.frame));
        
        if (![LsMethod haveValue:model.fromUserName]) {
            model.fromUserName =@"齐天大圣";
        }
        
        if (![LsMethod haveValue:model.toUserName]) {
            model.toUserName =@"唐僧";
        }
        
        NSString  *nameStr    =[NSString stringWithFormat:@"%@回复%@",model.fromUserName,model.toUserName];
        nameL.attributedText  =[LsMethod changeColorWithStr:nameStr RangeStr:@"回复"];
        
        if (baseView.frame.size.height<70*LSScale) {
            line.frame            =CGRectMake(0, CGRectGetMaxY(iconView.frame)+10*LSScale, LSMainScreenW, 0.5);
            baseView.frame        =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
        }
        self.frame                =baseView.frame;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
