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
    UIView         *line;
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
        titleL.numberOfLines    =0;
        [baseView addSubview:titleL];
        
        timeL                   =[[UILabel alloc] initWithFrame:CGRectMake(10*LSScale, CGRectGetMaxY(titleL.frame), LSMainScreenW-60*LSScale, 20*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:12*LSScale];
        timeL.textColor         =[UIColor darkGrayColor];
        timeL.textAlignment     =NSTextAlignmentLeft;
        [baseView addSubview:timeL];
        
        UIImage      *ima       =[UIImage imageNamed:@"hsh"];
        UIImageView  *playView  =[[UIImageView alloc] initWithFrame:CGRectMake(LSMainScreenW-15*LSScale-ima.size.width, CGRectGetHeight(baseView.frame)/2-ima.size.height/2, ima.size.width, ima.size.height)];
        playView.image          =ima;
        [baseView addSubview:playView];
        
        line                    =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(baseView.frame)-0.5*LSScale, LSMainScreenW, 0.5*LSScale)];
        line.backgroundColor =LSLineColor;
        [baseView addSubview:line];
    }
    return self;
}

-(void)reloadCellWithData:(LsCourseArrangementModel*)model{
    CGSize  size =[LsMethod sizeWithSize:CGSizeMake(CGRectGetWidth(titleL.frame), 8000) String:model.title font:titleL.font];
    titleL.frame =CGRectMake(titleL.frame.origin.x, titleL.frame.origin.y, titleL.frame.size.width, size.height);
    titleL.text  =model.title;
    timeL.frame  =CGRectMake(timeL.frame.origin.x,CGRectGetMaxY(titleL.frame), timeL.frame.size.width, timeL.frame.size.height);
    baseView.frame =CGRectMake(baseView.frame.origin.x,baseView.frame.origin.y, baseView.frame.size.width, CGRectGetMaxY(timeL.frame)+0.5*LSScale);
    line.frame     =CGRectMake(0, CGRectGetHeight(baseView.frame)-0.5*LSScale, LSMainScreenW, 0.5*LSScale);
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:model.stopTime];
    NSString  *stopStr = [LsMethod dateStrFromDate:date AndFormat:@"HH:mm:ss"];
    timeL.text   =[NSString stringWithFormat:@"%@-%@",model.startTime,stopStr];
    
    self.frame    =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(baseView.frame));
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
