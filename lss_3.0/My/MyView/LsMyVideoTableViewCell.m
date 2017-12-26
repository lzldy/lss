//
//  LsMyVideoTableViewCell.m
//  lss
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyVideoTableViewCell.h"

@interface LsMyVideoTableViewCell ()
{
    UILabel     *titleL;
    UIImageView *imageView;
    UILabel     *timeL;
    UIView      *backgroundView;
    LsButton    *reUploadBtn;
    LsButton    *deleteBtn;

}
@end

@implementation LsMyVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor      =LSColor(243, 244, 245, 1);
        backgroundView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LSMainScreenW, 10*LSScale)];
        backgroundView.backgroundColor =[UIColor whiteColor];
        [self addSubview:backgroundView];
        
        titleL                   =[[UILabel alloc] init];
        titleL.font              =[UIFont systemFontOfSize:14*LSScale];
        titleL.textAlignment     =NSTextAlignmentLeft;
        [backgroundView addSubview:titleL];
        
        imageView                =[[UIImageView alloc] init];
        imageView.frame          =CGRectMake(10*LSScale, 10*LSScale, 65*LSScale, 65*LSScale);
        imageView.contentMode    =UIViewContentModeScaleAspectFit;
        [backgroundView addSubview:imageView];
        
        timeL                    =[[UILabel alloc] init];
        timeL.font               =[UIFont systemFontOfSize:12*LSScale];
        timeL.textAlignment      =NSTextAlignmentLeft;
        timeL.textColor          =[UIColor darkGrayColor];
        [backgroundView addSubview:timeL];
        
        deleteBtn                  =[[LsButton alloc] initWithFrame:CGRectMake(LSMainScreenW-10*LSScale-30*LSScale, CGRectGetMidY(imageView.frame)-15*LSScale, 30*LSScale, 30*LSScale)];
        [deleteBtn setImage:LOADIMAGE(@"delete") forState:0];
        [deleteBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag              =0;
        [backgroundView addSubview:deleteBtn];
        
        
        reUploadBtn                  =[[LsButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(deleteBtn.frame)-35*LSScale, CGRectGetMidY(imageView.frame)-15*LSScale, 30*LSScale, 30*LSScale)];
        [reUploadBtn setImage:LOADIMAGE(@"sc") forState:0];
        [reUploadBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        reUploadBtn.tag              =1;
        [backgroundView addSubview:reUploadBtn];

    }
    return self;
}

-(void)didClickBtn:(LsButton*)btn{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickBtnIndex:)]) {
        [self.delegate didClickBtnIndex:btn];
    }
    
}

-(void)reloadCell:(LsMyVideoModel *)model  type:(NSString*)type{
    NSString  *timeStr           =@"";
    reUploadBtn.hidden           =YES;
    if ([type isEqualToString:@"1"]) {
        titleL.frame          =CGRectMake(CGRectGetMaxX(imageView.frame)+12*LSScale,CGRectGetMidY(imageView.frame)-26*LSScale, CGRectGetMinX(deleteBtn.frame)-CGRectGetMaxX(imageView.frame)-10*LSScale, 26*LSScale);
        timeL.frame           =CGRectMake(CGRectGetMaxX(imageView.frame)+12*LSScale,CGRectGetMidY(imageView.frame), CGRectGetMinX(deleteBtn.frame)-CGRectGetMaxX(imageView.frame)-10*LSScale, 26*LSScale);
        timeStr               = [LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"yyyy年MM月dd日 HH:mm"];

    }else{
        reUploadBtn.hidden    =NO;
        titleL.frame          =CGRectMake(CGRectGetMaxX(imageView.frame)+12*LSScale,CGRectGetMidY(imageView.frame)-26*LSScale, CGRectGetMinX(reUploadBtn.frame)-CGRectGetMaxX(imageView.frame)-10*LSScale, 26*LSScale);
        timeL.frame           =CGRectMake(CGRectGetMaxX(imageView.frame)+12*LSScale,CGRectGetMidY(imageView.frame), CGRectGetMinX(reUploadBtn.frame)-CGRectGetMaxX(imageView.frame)-10*LSScale, 26*LSScale);
        timeStr               = [LsMethod toDateWithTimeStamp:model.startTime DateFormat:@"yyyy年MM月dd日"];

    }

    if ([LsMethod haveValue:model.videoHeadUrl2]) {
        [imageView sd_setImageWithURL:model.videoHeadUrl2 placeholderImage:[UIImage imageNamed:@"zhibo"]];
    }else{
        [imageView sd_setImageWithURL:model.videoHeadUrl placeholderImage:model.image];
    }
    
    backgroundView.frame =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(imageView.frame)+10*LSScale);
    self.frame           =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(backgroundView.frame)+10*LSScale);
    titleL.text          =model.title;
    timeL.text           =[NSString stringWithFormat:@"直播时间:%@",timeStr];
    deleteBtn.ID         =model.code;
    deleteBtn.videoID    =model.title;
    reUploadBtn.videoID  =model.title;
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
