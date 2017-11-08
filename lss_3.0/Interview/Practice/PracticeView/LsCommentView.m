//
//  LsCommentView.m
//  lss
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCommentView.h"

@interface LsCommentView ()<UITextViewDelegate>
{
    UITextView *textView_;
    UIButton   *commitBtn;
}
@end

@implementation LsCommentView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.frame           = CGRectMake(0,0, LSMainScreenW, LSMainScreenH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        textView_                     =[[UITextView alloc] initWithFrame:CGRectMake(20*LSScale, 120*LSScale, LSMainScreenW-40*LSScale, 125*LSScale)];
        textView_.layer.borderColor   =LSNavColor.CGColor;
        textView_.layer.borderWidth   =1;
        textView_.textColor           =LSColor(102, 102, 102, 1);
        textView_.delegate            =self;
        textView_.font                =[UIFont systemFontOfSize:13*LSScale];
        [self addSubview:textView_];
        
        UIImage *image              =[UIImage imageNamed:@"gb_button"];
        
        UIButton  *closeBtn         =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textView_.frame)-image.size.width/2, CGRectGetMinY(textView_.frame) -image.size.height/2,  image.size.width,image.size.height)];
        [closeBtn setImage:image forState:0];
        [closeBtn addTarget:self action:@selector(didClickCloseBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        commitBtn         =[[UIButton alloc] initWithFrame:CGRectMake(20*LSScale, CGRectGetMaxY(textView_.frame),  LSMainScreenW-40*LSScale, 35*LSScale)];
        commitBtn.backgroundColor    =LSNavColor;
        [commitBtn setTitleColor:[UIColor whiteColor] forState:0];
        [commitBtn addTarget:self action:@selector(didClickCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:commitBtn];
    }
    return self;
}

-(void)setTextPlaceholder:(NSString *)textPlaceholder{
    _textPlaceholder =textPlaceholder;
    textView_.text   =textPlaceholder;
}

-(void)setCommitBtnText:(NSString *)commitBtnText{
    _commitBtnText   =commitBtnText;
    [commitBtn setTitle:commitBtnText forState:0];
}
-(void)didClickCloseBtnBtn:(UIButton *)button{
    [self removeFromSuperview];
}

-(void)didClickCommitBtn:(UIButton*)button{
    if (![LsMethod haveValue:textView_.text]||[textView_.text isEqualToString:self.textPlaceholder]) {
        [LsMethod alertMessage:@"请写下你的想法之后再发送哦~" WithTime:1.5];
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickCommitButton:)]) {
            [self.delegate didClickCommitButton:textView_.text];
        }
        [self removeFromSuperview];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    textView_.textColor               =[UIColor darkTextColor];
    textView.text                     =@"";
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (![LsMethod haveValue:textView_.text]) {
        textView_.textColor           =LSColor(102, 102, 102, 1);
        textView_.text                =_textPlaceholder;
    }
}

@end
