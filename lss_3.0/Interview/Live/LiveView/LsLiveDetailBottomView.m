//
//  LsLiveDetailBottomView.m
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLiveDetailBottomView.h"
#import "LsButton.h"

@interface LsLiveDetailBottomView ()
{
    UILabel     *freeL;
    LsButton    *consultationBtn;
    LsButton    *enrollBtn;
}

@end

@implementation LsLiveDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        
        UIView *line         =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        line.backgroundColor =LSLineColor;
        [self addSubview:line];
        
        freeL                =[[UILabel alloc] initWithFrame:CGRectMake(0, 0.5, 110*LSScale, self.frame.size.height)];
        freeL.textColor      =LSNavColor;
        freeL.textAlignment  =NSTextAlignmentCenter;
        freeL.font           =[UIFont systemFontOfSize:19];
        [self addSubview:freeL];
        
        UIView *line1         =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(freeL.frame), 0, 0.5, self.frame.size.height)];
        line1.backgroundColor =LSLineColor;
        [self addSubview:line1];
        
        consultationBtn       =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame), 0, self.frame.size.height,self.frame.size.height)];
        [consultationBtn setImage:[UIImage imageNamed:@"zx"] forState:0];
        [consultationBtn addTarget:self action:@selector(didClickConsultationBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:consultationBtn];
        
        enrollBtn       =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(consultationBtn.frame), 0,self.frame.size.width-CGRectGetMaxX(consultationBtn.frame), self.frame.size.height)];
        enrollBtn.backgroundColor =LSNavColor;
        [enrollBtn setTitle:@"马上报名" forState:UIControlStateNormal];
        [enrollBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        enrollBtn.titleLabel.font  =[UIFont systemFontOfSize:19 ];
        [enrollBtn addTarget:self action:@selector(didClickEnrollBtnBtn:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:enrollBtn];
    }
    return self;
}

-(void)didClickEnrollBtnBtn:(LsButton*)button{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didEnrollSuccess:)]) {
        [self.delegate didEnrollSuccess:_model];
    }
    
}

-(void)didClickConsultationBtn:(LsButton*)button{
    [LSApplication openURL:LSCustomerService];

//    [LsMethod alertMessage:@"咨询" WithTime:2];
}

-(void)setModel:(LsLiveDetailModel *)model{
    _model=model;
//    if (_model.isFree) {
//        freeL.text= @"免费";
//    }
    freeL.text= @"推荐";

//    _model.isEnroll =NO;
    if (_model.mybuy) {
        [enrollBtn setTitle:@"已报名" forState:UIControlStateNormal];
        enrollBtn.userInteractionEnabled =NO;
    }else{
        [enrollBtn setTitle:@"马上报名" forState:UIControlStateNormal];
        enrollBtn.userInteractionEnabled =YES;
    }
}
@end
