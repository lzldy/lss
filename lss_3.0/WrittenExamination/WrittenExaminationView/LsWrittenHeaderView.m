//
//  LsWrittenHeaderView.m
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsWrittenHeaderView.h"

@implementation LsWrittenHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius =6;
        self.backgroundColor    =[UIColor whiteColor];
    }
    return self;
}

-(void)setDataDcit:(NSDictionary *)dataDcit{
    _dataDcit                  =dataDcit;
    float width                = (self.frame.size.width-1*LSScale)/3;
    UILabel *testpPaperL       =[[UILabel alloc] initWithFrame:CGRectMake(0, 20*LSScale, width, 20*LSScale)];
    testpPaperL.textColor      = LSNavColor;
    testpPaperL.textAlignment  =NSTextAlignmentCenter;
    testpPaperL.font           =[UIFont systemFontOfSize:18*LSScale];
    testpPaperL.text           =dataDcit[@"testPaper"];
    [self addSubview:testpPaperL];
    
    UILabel *testpPaperDL      =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(testpPaperL.frame)+5*LSScale, width, 18*LSScale)];
    testpPaperDL.textColor     =[UIColor darkGrayColor];
    testpPaperDL.textAlignment =NSTextAlignmentCenter;
    testpPaperDL.font          =[UIFont systemFontOfSize:13*LSScale];
    testpPaperDL.text          =@"共做试卷";
    [self addSubview:testpPaperDL];
    
    UIView  *line              =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testpPaperL.frame), CGRectGetMinY(testpPaperL.frame), 0.5*LSScale, 41*LSScale)];
    line.backgroundColor       =LSLineColor;
    [self addSubview:line];
    
    UILabel *testQuestionL       =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 20*LSScale, width, 20*LSScale)];
    testQuestionL.textColor      = LSNavColor;
    testQuestionL.textAlignment  =NSTextAlignmentCenter;
    testQuestionL.font           =[UIFont systemFontOfSize:18*LSScale];
    testQuestionL.text           =dataDcit[@"testQuestions"];
    [self addSubview:testQuestionL];
    
    UILabel *testQuestionDL      =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), CGRectGetMaxY(testQuestionL.frame)+5*LSScale, width, 18*LSScale)];
    testQuestionDL.textColor     =[UIColor darkGrayColor];
    testQuestionDL.textAlignment =NSTextAlignmentCenter;
    testQuestionDL.font          =[UIFont systemFontOfSize:13*LSScale];
    testQuestionDL.text          =@"共做对试题";
    [self addSubview:testQuestionDL];
    
    UIView  *lineTwo             =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testQuestionL.frame), CGRectGetMinY(testQuestionL.frame), 0.5*LSScale, 41*LSScale)];
    lineTwo.backgroundColor       =LSLineColor;
    [self addSubview:lineTwo];
    
    UILabel *correctRateL       =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineTwo.frame), 20*LSScale, width, 20*LSScale)];
    correctRateL.textColor      = LSNavColor;
    correctRateL.textAlignment  =NSTextAlignmentCenter;
    correctRateL.font           =[UIFont systemFontOfSize:18*LSScale];
    correctRateL.text           =dataDcit[@"correctRate"];
    [self addSubview:correctRateL];
    
    UILabel *correctRateDL      =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineTwo.frame), CGRectGetMaxY(correctRateL.frame)+5*LSScale, width, 18*LSScale)];
    correctRateDL.textColor     =[UIColor darkGrayColor];
    correctRateDL.textAlignment =NSTextAlignmentCenter;
    correctRateDL.font          =[UIFont systemFontOfSize:13*LSScale];
    correctRateDL.text          =@"正确率";
    [self addSubview:correctRateDL];
   
    

}

@end
