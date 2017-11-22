//
//  LsLiveDetailTableViewCell.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailTableViewCell.h"
#import "LsButton.h"

@interface LsLiveDetailTableViewCell ()
{
    UIView            *baseView;
    UILabel           *titleL;
    UIImageView       *timeIV;
    UILabel           *timeL;
    UILabel           *testTitleL;
    LsButton          *playBtn;
    LsButton          *testBtn;
}
@end

@implementation LsLiveDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor    =[UIColor clearColor];
        baseView        =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 110*LSScale)];
        baseView.backgroundColor =[UIColor whiteColor];
        [self addSubview:baseView];
        
        titleL        =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale, 15*LSScale, LSMainScreenW-40, 25*LSScale)];
        titleL.font             =[UIFont systemFontOfSize:17];
        titleL.textColor        =[UIColor darkTextColor];
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:titleL];
        
        UIImage      *image     =[UIImage imageNamed:@"time_icon"];
        timeIV    =[[UIImageView alloc] initWithFrame:CGRectMake(15*LSScale,CGRectGetMaxY(titleL.frame)+10*LSScale,15*LSScale, 15*LSScale)];
        timeIV.image            =image;
        [baseView addSubview:timeIV];
        
        timeL         =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeIV.frame)+10,CGRectGetMidY(timeIV.frame)-10*LSScale, LSMainScreenW-timeL.frame.origin.x, 20*LSScale)];
        timeL.font              =[UIFont systemFontOfSize:14];
        timeL.textColor         =LSColor(153, 153, 153, 1);
        titleL.textAlignment    =NSTextAlignmentLeft;
        [baseView addSubview:timeL];
        
        UIView* line           =[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(timeL.frame)+10*LSScale, LSMainScreenW, 0.5)];
        line.backgroundColor   =LSLineColor;
        [baseView addSubview:line];
        
        testTitleL   =[[UILabel alloc] initWithFrame:CGRectMake(15*LSScale,CGRectGetMaxY(line.frame), CGRectGetWidth(baseView.frame)-80*LSScale , 35*LSScale)];
        testTitleL.textAlignment =NSTextAlignmentLeft;
        testTitleL.textColor     =[UIColor darkGrayColor];
        testTitleL.font          =[UIFont systemFontOfSize:16];
        [baseView addSubview:testTitleL];
        
        
        playBtn              =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(baseView.frame)-53*LSScale, CGRectGetMinY(line.frame)/2*LSScale-18*LSScale, 36*LSScale, 36*LSScale)];
        [playBtn setImage:[UIImage imageNamed:@"wks_button_after"] forState:0];
        [playBtn addTarget:self action:@selector(clickPlayBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:playBtn];
        
        testBtn              =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(playBtn.frame)-40*LSScale, CGRectGetMaxY(line.frame)+2.5*LSScale, 80*LSScale, 30*LSScale)];
        [testBtn setTitle:@"我要做题" forState:0];
        [testBtn setTitleColor:LSNavColor forState:0];
        testBtn.titleLabel.font       =[UIFont systemFontOfSize:14];
        [testBtn addTarget:self action:@selector(clickTestBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:testBtn];
    }
    return self;
}

-(void)reloadCell:(LsCourseArrangementModel*)model{
    
    titleL.text         =model.title;
    NSString *startDate =[LsMethod toDateWithTimeStamp:model.startDate DateFormat:@"yyyy.MM.dd"];
    NSString *startTime =[LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"HH:mm"];
    timeL.text          =[NSString stringWithFormat:@"%@ %@开始",startDate,startTime];
    testTitleL.text     =model.testPaperTitle;
    if (![LsMethod haveValue:model.testPaperTitle]) {
        testTitleL.text     =@"语文备考系列考试密卷";
    }
    playBtn.videoID     =model.videoId;
    playBtn.livevideos  =model.livevideos;
    playBtn.isEnroll    =model.mybuy;
    playBtn.title       =model.title;
    testBtn.url         =model.testUrl;
}

-(void)clickPlayBtnBtn:(LsButton*)button{
    if (button.isEnroll) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickPlayBtnWithID:)]) {
            [self.delegate didClickPlayBtnWithID:button];
        }
    }else{
        [LsMethod alertMessage:@"请先报名" WithTime:1.5];
    }
}

-(void)clickTestBtnBtn:(LsButton*)button{
    [LsMethod alertMessage:[NSString stringWithFormat:@"跳转浏览器---%@",button.url] WithTime:2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
