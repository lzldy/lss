//
//  LSLabel+TextField.m
//  分类
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LSLabel+TextField.h"
@interface LSLabel_TextField ()

//@property (nonatomic,strong)  UILabel *label;

@end

@implementation LSLabel_TextField

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor       = [UIColor whiteColor];
        
        UILabel *label             = [[UILabel alloc]init];
        label.numberOfLines        = 0; // 需要把显示行数设置成无限制
        label.font                 = [UIFont systemFontOfSize:17];
        label.textColor            = [UIColor darkTextColor];
        [self addSubview:label];
        self.label =label;
        
        UITextField *textField     = [[UITextField alloc] init];
        textField.keyboardType     = UIKeyboardTypeNumberPad;
        textField.returnKeyType    = UIReturnKeyDone;
        textField.font             = [UIFont systemFontOfSize:16];
        [self addSubview:textField];
        self.textField=textField;
    }
    return self;
}

// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典
                                       context:nil];
    
    return rect.size;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray=dataArray;
    if (dataArray.count>0) {
        if (dataArray.count==1) {
            self.label.text  =dataArray[0];
        }
        if (dataArray.count==2) {
            self.label.text            =dataArray[0];
            self.textField.placeholder =dataArray[1];
        }
    }
    
    CGSize size                = [self sizeWithString:self.label.text font:self.label.font];
    LsLog(@"================%@",NSStringFromCGSize(size));
    //宽高 都自适应
    //    label.bounds = CGRectMake(0, 0, size.width, size.height);
    //给定高度 只适应宽度  其实这里的bounds可以换成frame
    self.label.frame     = CGRectMake(15, 0, size.width,self.frame.size.height);
    
    self.textField.frame =CGRectMake(CGRectGetMaxX(self.label.frame), 0, LSMainScreenW-CGRectGetMaxX(self.label.frame)-15, self.frame.size.height);
}

@end
