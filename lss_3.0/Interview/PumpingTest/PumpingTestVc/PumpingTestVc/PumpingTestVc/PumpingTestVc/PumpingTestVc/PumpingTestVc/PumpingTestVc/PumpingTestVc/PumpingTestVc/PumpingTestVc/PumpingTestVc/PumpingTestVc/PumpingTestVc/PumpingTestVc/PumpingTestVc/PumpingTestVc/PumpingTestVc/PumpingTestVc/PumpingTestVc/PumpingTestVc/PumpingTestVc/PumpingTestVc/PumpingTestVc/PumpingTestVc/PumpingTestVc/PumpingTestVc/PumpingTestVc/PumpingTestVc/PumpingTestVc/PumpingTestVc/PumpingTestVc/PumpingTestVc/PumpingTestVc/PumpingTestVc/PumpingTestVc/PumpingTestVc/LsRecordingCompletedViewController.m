//
//  LsRecordingCompletedViewController.m
//  lss
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsRecordingCompletedViewController.h"

@interface LsRecordingCompletedViewController ()

@end

@implementation LsRecordingCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle  =@"视频完成";
    [self loadBaseUI];

}

-(void)loadBaseUI{
    UIImageView *videoImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, LSMainScreenW*LSScaleW_H)];
    videoImgView.image = [LsMethod thumbnailImageForVideo:_videoURL atTime:1];
    [superView addSubview:videoImgView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
