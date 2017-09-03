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
    UIButton    *replyBtn;
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
        iconView.layer.backgroundColor  =[UIColor redColor].CGColor;
        [baseView addSubview:iconView];

        
        nameL                  =[[UILabel alloc] initWithFrame:CGRectMake(5*LSScale+CGRectGetMaxX(iconView.frame), CGRectGetMinY(iconView.frame),80*LSScale, 25*LSScale)];
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
        
        replyBtn             =[[UIButton alloc] init];
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

-(void)didClickReplyBtn:(UIButton *)button{
    [LsMethod alertMessage:@"回复老师点评" WithTime:1.5];
}

-(void)reloadCellWithData:(id)data type:(NSString*)type{
    
    nameL.text            =@"王二小";
    timeL.text            =@"2017-09-03";
    commentL.text         =@"卡夫卡方式啥地方卡上和嘎哈的骄傲和大家安静倒海翻江安徽的发件湿的还时间的话房间爱上对方和经适房时间的话副书记的好几个还是大家和我我我我我问我阿萨德家里卡登记反馈的数据发开落落大方卡上可视对讲方面只能沉默，v就发到松开立即福克斯地方开发经十东路风景老师的法律；问发到空间发；上岛咖啡技术的回放闪电发货大护法喝完酒二环附近卡萨丁 技术的后发酵闪电发货";
    CGSize  size          =[LsMethod sizeWithSize:CGSizeMake(commentL.frame.size.width, 8000) String:commentL.text font:commentL.font];
    commentL.frame        =CGRectMake(commentL.frame.origin.x, commentL.frame.origin.y, commentL.frame.size.width, size.height);
    line.frame            =CGRectMake(0, CGRectGetMaxY(commentL.frame)+10*LSScale, LSMainScreenW, 0.5);
    baseView.frame        =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
    if ([type isEqualToString:@"0"]) {
        self.frame        =baseView.frame;
    }else if ([type isEqualToString:@"1"]){
        replyBtn.frame    =CGRectMake(LSMainScreenW-10*LSScale-65*LSScale, CGRectGetMaxY(commentL.frame)+10*LSScale, 65*LSScale, 25*LSScale);
        line.frame        =CGRectMake(0, CGRectGetMaxY(replyBtn.frame)+10*LSScale, LSMainScreenW, 0.5);
        baseView.frame    =CGRectMake(0, 0,LSMainScreenW, CGRectGetMaxY(line.frame));
        self.frame        =CGRectMake(0, 0, LSMainScreenW,  CGRectGetMaxY(line.frame)+10*LSScale);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
