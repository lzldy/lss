//
//  LsActivityTableViewCell.m
//  lss
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsActivityTableViewCell.h"

@interface LsActivityTableViewCell (){
    UIImageView *imageView_;
}
@end

@implementation LsActivityTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor     =LSColor(243, 244, 245, 1);
        
        imageView_               =[[UIImageView alloc] initWithFrame:CGRectMake(0,10*LSScale, LSMainScreenW, 150*LSScale)];
        imageView_.contentMode =UIViewContentModeScaleAspectFit;
        [self addSubview:imageView_];
        
    }
    return self;
}

-(void)reloadCell:(id)model{
    UIImage *placeImage     =[UIImage imageNamed:@"banner"];
    [imageView_ sd_setImageWithURL:nil placeholderImage:placeImage];
    
    imageView_.frame        =CGRectMake(0, 10*LSScale, LSMainScreenW,  placeImage.size.height/placeImage.size.width*LSMainScreenW);
    self.frame              =CGRectMake(0, 0, LSMainScreenW, CGRectGetMaxY(imageView_.frame));
    
}

@end
