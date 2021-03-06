//
//  LsMyLiveTabView.m
//  lss
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMyLiveTabView.h"

@interface LsMyLiveTabView ()
{
    NSArray  *titleArray;
    NSArray  *imageArray;
    NSArray  *selectedImageArray;
    NSMutableArray  *viewArray;
    BOOL     isScrollSwitch;
}
@end

@implementation LsMyLiveTabView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    titleArray          =@[@"今日直播",@"未开始",@"可回放"];
    imageArray          =@[@"zb_button_before",@"wks_button_before",@"hf_button_before"];
    selectedImageArray  =@[@"zb_button_after",@"wks_button_after",@"hf_button_after"];
    viewArray           =[NSMutableArray array];
    for (int i=0; i<titleArray.count; i++) {
        LsButton *view =[[LsButton alloc] initWithFrame:CGRectMake(i*self.frame.size.width/titleArray.count, 0,self.frame.size.width/titleArray.count, self.frame.size.height)];
        [self addSubview:view];
        
        UIImage  *image     =[UIImage imageNamed:imageArray[i]];
        UIImage  *imaged    =[UIImage imageNamed:selectedImageArray[i]];

        view.lsImageView.frame =CGRectMake(view.frame.size.width/2-image.size.width/2, 15, image.size.width, image.size.height);
        view.lsImageView.image =image;
        view.tag               =i;
        [view addTarget:self action:@selector(didClickBtn:isScrollSwitch:) forControlEvents:UIControlEventTouchUpInside];

        view.lsLabel.frame     =CGRectMake(0, CGRectGetMaxY(view.lsImageView.frame)+10, view.frame.size.width,20);
        view.lsLabel.text            =titleArray[i];
        view.lsLabel.textColor       =[UIColor darkTextColor];
        view.lsLabel.textAlignment   =NSTextAlignmentCenter;
        view.lsLabel.font            =[UIFont systemFontOfSize:14];
//        UIButton *button    =[[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width/2-image.size.width/2, 15, image.size.width, image.size.height)];
//        [button setImage:image  forState:UIControlStateNormal];
//        [button setImage:imaged forState:UIControlStateSelected];
//        button.tag          =i;
//        [view addTarget:self action:@selector(didClickBtn:isScrollSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
//        UILabel  *label       =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+10, view.frame.size.width,20)];
//        label.text            =titleArray[i];
//        label.textColor       =[UIColor darkTextColor];
//        label.textAlignment   =NSTextAlignmentCenter;
//        label.font            =[UIFont systemFontOfSize:14];
//        [view addSubview:label];
        NSDictionary *dict =@{@"btn":view.lsImageView,@"lab":view.lsLabel};
        [viewArray addObject:dict];
        if (i==0) {
            view.lsImageView.image=imaged;
            view.lsLabel.textColor=LSNavColor;
        }
    }
}

-(void)didClickBtn:(LsButton*)button isScrollSwitch:(BOOL)isOrNo{
    for (int i=0; i<viewArray.count; i++) {
        UIImage  *image     =[UIImage imageNamed:imageArray[i]];
        UIImage  *imaged    =[UIImage imageNamed:selectedImageArray[i]];
        
        NSDictionary *dict       =viewArray[i];
        UIImageView *imageV      =[dict objectForKey:@"btn"];
        UILabel     *lab         =[dict objectForKey:@"lab"];
        if (button.tag==i) {
            imageV.image   =imaged;
            lab.textColor  =LSNavColor;
        }else{
            imageV.image   =image;
            lab.textColor  =[UIColor darkTextColor];
        }
    }
    if (!isOrNo&&self.delegate&&[self.delegate respondsToSelector:@selector(didClickMyLiveTabViewIndex:)]) {
        [self.delegate didClickMyLiveTabViewIndex:button.tag];
    }
}

-(void)switchMyLiveTab:(NSInteger)index {
    LsButton *btn =[[LsButton alloc] init];
    btn.tag=index;
    [self didClickBtn:btn isScrollSwitch:YES];
}



@end
