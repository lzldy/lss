//
//  LsPlayBackTableViewCell.m
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPlayBackTableViewCell.h"

@interface LsPlayBackTableViewCell ()
{
    UIView         *baseView;
    UILabel        *titleL;
    UILabel        *timeL;
    UIButton       *playBtn;
}
@end

@implementation LsPlayBackTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =[UIColor clearColor];
        
        baseView                 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 50*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
        titleL                  =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, 5*LSScale, LSMainScreenW-60*LSScale, 20*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:14*LSScale];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:titleL];
        
        timeL                   =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(titleL.frame), LSMainScreenW-60*LSScale, 20*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:12*LSScale];
        timeL.textColor         =[UIColor darkGrayColor];
        timeL.textAlignment     =NSTextAlignmentLeft;
        [baseView addSubview:timeL];
        
        UIImage      *ima       =[UIImage imageNamed:@"hsh"];
        playBtn                 =[[UIButton alloc] initWithFrame:CGRectMake(LSMainScreenW-15*LSScale-ima.size.width, CGRectGetHeight(baseView.frame)/2-ima.size.height/2, ima.size.width, ima.size.height)];
        [playBtn setImage:ima forState:0];
        [baseView addSubview:playBtn];
        
        UIView * line                 =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(baseView.frame)-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
        line.backgroundColor =LSLineColor;
        [baseView addSubview:line];
    }
    return self;
}

-(void)reloadCellWithData:(LsLiveModel*)model{
    titleL.text          =model.title;
    NSString *dateStr    =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"MM月dd日"];
    NSString *startTime  =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
    NSString *endTime    =[LsMethod toDateWithTimeStamp:model.endTime   DateFormat:@"HH:mm"];
    timeL.text   =[NSString stringWithFormat:@"%@ %@-%@",dateStr,startTime,endTime];
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
