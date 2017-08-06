//
//  LsBaseCollectionViewCell.m
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseCollectionViewCell.h"
#import "LsConfigureModel.h"

@implementation LsBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor   =[UIColor whiteColor];
        UILabel  *label        =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.layer.borderWidth=1;
        label.layer.borderColor=LSNavColor.CGColor;
        label.textColor        =LSNavColor;
        label.textAlignment    =NSTextAlignmentCenter;
        label.font             =[UIFont systemFontOfSize:16];
        self.label             =label;
        [self addSubview:label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        //选中时
        self.label.backgroundColor  =LSNavColor;
        self.label.textColor        =[UIColor whiteColor];
    }else{
        //非选中
        self.label.backgroundColor  =[UIColor whiteColor];
        self.label.textColor        =LSNavColor;
    }
    
    // Configure the view for the selected state
}

-(void)reloadDataWith:(id)data{
    LsConfigureModel *model =data;
    if (model.didSelect) {
        self.selected=YES;
    }else{
        self.selected=NO;
    }
    self.label.text =model.title;
}

@end
