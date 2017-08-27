//
//  LsCustomPlayerViewController.m
//  lss
//
//  Created by apple on 2017/8/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCustomPlayerViewController.h"
#import "DWPlayerView.h"

@implementation LsVideoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"videoModelArray"    : [LsVideoModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"videoModelArray"    : @"qualities"};
}

@end

@interface LsCustomPlayerViewController ()<DWVideoPlayerDelegate>

@property (nonatomic,strong) DWPlayerView *playerView;
@property (nonatomic,strong) LsVideoModel *model;
@property (nonatomic,assign) NSInteger    qualityIndex;

@end

@implementation LsCustomPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden =YES;
    [self loadBaseUI];
    [self getPlayUrl];
}

-(void)loadBaseUI{
    [superView addSubview:self.playerView];
}

-(void)getPlayUrl{
    self.playerView.videoId =@"2DBC15008476D84C9C33DC5901307461";
    [self.playerView startRequestPlayInfo];
    
    __weak __typeof(self)weakSelf = self;
    self.playerView.getPlayUrlsBlock = ^(NSDictionary *playUrls) {
        NSNumber *status = [playUrls objectForKey:@"status"];
        if (status == nil || [status integerValue] != 0) {
            [LsMethod alertMessage:@"视频正在审核中,请稍后再试" WithTime:1.5];
        }
        weakSelf.model        =[LsVideoModel yy_modelWithDictionary:playUrls];
        LsVideoModel *modelll =weakSelf.model.videoModelArray[weakSelf.qualityIndex];
        [weakSelf.playerView setURL:modelll.playurl withCustomId:CHANNEL];
        [weakSelf.playerView play];
    };
}

// 可播放／播放中
- (void)videoPlayerIsReadyToPlayVideo:(DWPlayerView *)playerView{
//    [self.playerView play];
}

//播放完毕
- (void)videoPlayerDidReachEnd:(DWPlayerView *)playerView{
    
}

//当前播放时间 已经切换到主线程 可直接更新UI
- (void)videoPlayer:(DWPlayerView *)playerView timeDidChange:(CMTime)cmTime{
    
}

//duration 当前缓冲的长度
- (void)videoPlayer:(DWPlayerView *)playerView loadedTimeRangeDidChange:(float)duration{
    
}

//进行跳转后没数据 即播放卡顿
- (void)videoPlayerPlaybackBufferEmpty:(DWPlayerView *)playerView{
    
}

//加载失败
- (void)videoPlayer:(DWPlayerView *)playerView didFailWithError:(NSError *)error{
    
}

-(DWPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[DWPlayerView alloc] initWithUserId:CC_USERID key:CC_APIKEY];
        _playerView.frame =CGRectMake(0,64,LSMainScreenW,LSMainScreenH/2-50);
        _playerView.videoGravity =AVLayerVideoGravityResizeAspectFill;
        _playerView.delegate =self;//设置代理
        _playerView.backgroundColor =LSLineColor;
    }
    return _playerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
