//
//  LsVideotapeViewController.m
//  lss
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#define DEFAULT_RECORD_TIME  (60*10)

#import "LsVideotapeViewController.h"
#import "AVCaptureManager.h"
#import "LsRecordingCompletedViewController.h"

@interface LsVideotapeViewController ()<AVCaptureManagerDelegate>
{
    AVCaptureManager *captureManager;
    NSTimer          *timer_;
    UIButton         *startBtn;
    UILabel          *timeLabel;
    int              remainSeconds;
    UIButton         *reStartBtn;
    BOOL             isNeededToSave;
}
@end

@implementation LsVideotapeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer_ invalidate];
    timer_ = nil;
    [captureManager stopRecording];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.navTitle =@"准备录制中···";
    [self.navView.rightButton setTitle:@"切换" forState:0];
    [self.navView.rightButton addTarget:self action:@selector(switchCamera) forControlEvents:UIControlEventTouchUpInside];
    captureManager = [[AVCaptureManager alloc] initWithPreviewView:superView];
    captureManager.delegate = self;
    [self loadBaseUI];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeRight] forKey:@"orientation"];//这里可以给个按钮 选择横屏录制或者竖屏录制

}

-(void)loadBaseUI{
    
    startBtn    =[[UIButton alloc]  initWithFrame:CGRectMake(LSMainScreenW/2-40*LSScale, LSMainScreenH-30*LSScale-80*LSScale, 80*LSScale, 80*LSScale)];
    startBtn.layer.masksToBounds=YES;
    startBtn.layer.cornerRadius =40*LSScale;
    startBtn.backgroundColor = LSNavColor;
    [startBtn addTarget:self action:@selector(startButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"开始录制" forState:UIControlStateNormal];
    startBtn.titleLabel.font  =[UIFont systemFontOfSize:15*LSScale];
    [superView addSubview:startBtn];
    
    timeLabel   =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(startBtn.frame), CGRectGetMinY(startBtn.frame)-30*LSScale, CGRectGetWidth(startBtn.frame), 20*LSScale)];
    timeLabel.font = [UIFont systemFontOfSize:13*LSScale];
    timeLabel.textColor = [UIColor whiteColor];
    [superView addSubview:timeLabel];
    
    reStartBtn     =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startBtn.frame)+20*LSScale, CGRectGetMidY(startBtn.frame)-15*LSScale, LSMainScreenW-CGRectGetMaxX(startBtn.frame)-40*LSScale, 30*LSScale)];
    [reStartBtn addTarget:self action:@selector(willReStartBtn) forControlEvents:UIControlEventTouchUpInside];
    reStartBtn.titleLabel.font  =[UIFont systemFontOfSize:13*LSScale];
    [reStartBtn setTitle:@"重新录制" forState:UIControlStateNormal];
    [reStartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reStartBtn.layer.backgroundColor =LSNavColor.CGColor;
    reStartBtn.layer.cornerRadius    =6*LSScale;
    [superView addSubview:reStartBtn];
    
    [self setData];
}

- (void)startButtonTapped:(UIButton *)button
{
    if (!captureManager) {
        return;
    }
    self.navView.navTitle = @"录制中...";
    if ([startBtn.titleLabel.text isEqualToString:@"上传"]) {
        [startBtn setTitle:@"开始录制" forState:UIControlStateNormal];
        [self nextButtonTapped:nil];
    }else{
        [startBtn setTitle:@"上传" forState:UIControlStateNormal];
        [self willReStartBtn];
    }
}

- (void)nextButtonTapped:(UIButton *)button
{
    if (captureManager.isRecording) {
        
        [LsMethod alertMessage:@"正在保存视频" WithTime:1];
        [timer_ invalidate];
        timer_ = nil;
        isNeededToSave = YES;
        [captureManager stopRecording];
    }
}

-(void)willReStartBtn{
    [startBtn setTitle:@"上传" forState:UIControlStateNormal];
    if (!timer_) {
        remainSeconds = DEFAULT_RECORD_TIME;
        int min = remainSeconds / 60;
        timeLabel.text = [NSString stringWithFormat:@"倒计时 %d:%02d", min, remainSeconds % 60];
        timer_ = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSRunLoopCommonModes];
        [timer_ fire];
    }
    
    if (captureManager.isRecording) {
        isNeededToSave = NO;
        [timer_ invalidate];
        timer_ = nil;
        [captureManager stopRecording];
        [LsMethod alertMessage:@"已重新开始录制" WithTime:1.5];
        [self performSelector:@selector(willReStartBtn) withObject:nil afterDelay:1.5];

    } else {
        [captureManager startRecording];
    }
}

- (void)time:(NSTimer *)timer{
    remainSeconds--;
    if (remainSeconds < 0) {
        remainSeconds = 0;
        [timer_ invalidate];
        timer_ = nil;
        [self nextButtonTapped:nil];
    }
    int min = remainSeconds / 60;
    timeLabel.text = [NSString stringWithFormat:@"倒计时 %d:%02d", min, remainSeconds % 60];
}

- (void)setData{
    remainSeconds = DEFAULT_RECORD_TIME;
    int min = remainSeconds / 60;
    timeLabel.text = [NSString stringWithFormat:@"倒计时 %d:%02d", min, remainSeconds % 60];
}

-(void)switchCamera{
    [captureManager swapFrontAndBackCameras];
}

- (void)didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                                  videoPath:(NSString*)parh
                                      error:(NSError *)error{
    if (error) {
        LsLog(@"didFinishRecordingToOutputFileAtURL errror %@", error);
        return;
    }
    LsLog(@"didFinishRecordingToOutputFileAtURL outputFileURL %@", outputFileURL);
    if (isNeededToSave) {
        LsRecordingCompletedViewController *vc = [[LsRecordingCompletedViewController alloc]init];
        vc.videoURL  = outputFileURL;
        vc.videoPath = parh;
        vc.videoTimeLength = DEFAULT_RECORD_TIME - remainSeconds;
            remainSeconds = DEFAULT_RECORD_TIME;
        int min = remainSeconds / 60;
        timeLabel.text = [NSString stringWithFormat:@"倒计时 %d:%02d", min, remainSeconds % 60];
        [startBtn setTitle:@"开始录制" forState:UIControlStateNormal];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)dealloc{
    LsLog(@"------------------------dealloc---------------------------");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
