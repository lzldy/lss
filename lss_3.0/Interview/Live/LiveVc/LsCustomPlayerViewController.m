//
//  LsCustomPlayerViewController.m
//  lss
//
//  Created by apple on 2017/8/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsCustomPlayerViewController.h"
#import "DWPlayerView.h"
#import "DWTools.h"

@implementation LsVideoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"videoModelArray"    : [LsVideoModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"videoModelArray"    : @"qualities"};
}

@end

@interface LsCustomPlayerViewController ()<DWVideoPlayerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImageView   *imageView;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,assign) CGRect        oldFrame;
@property (nonatomic,strong) DWPlayerView  *playerView;
@property (nonatomic,strong) LsVideoModel  *model;
@property (nonatomic,assign) NSInteger     qualityIndex;
//@property (nonatomic,assign) BOOL          isPlayable;
@property (nonatomic,assign) BOOL          didHiddenAll;

@property (nonatomic,assign) BOOL          isFullscreen;
@property (strong,nonatomic) NSTimer       *timer;
@property (assign,nonatomic) NSInteger     hiddenDelaySeconds;//隐藏所有view时间

@property (strong, nonatomic)UIView       *headerView;
@property (strong, nonatomic)UIView       *footerView;
@property (strong, nonatomic)UIView       *overlayView;

@property (strong, nonatomic)UIButton     *bigPauseButton;
@property (strong, nonatomic)UIButton     *backButton;

@property (strong, nonatomic)UIButton     *playButton;
@property (strong, nonatomic)UIButton     *switchButton;
@property (strong, nonatomic)UILabel      *currentPlaybackTimeLabel;
@property (strong, nonatomic)UISlider     *durationSlider;
@property (strong, nonatomic)UILabel      *totalTimeLabel;
@property (strong, nonatomic)UIButton     *definitionButton;

@property (assign, nonatomic)NSTimeInterval switchTime;

@property (strong, nonatomic) UITapGestureRecognizer  *signelTap;

@end

@implementation LsCustomPlayerViewController

- (id)initWithFrame:(CGRect)frame{
    self = [super init];
    [self.view setFrame:frame];
    _oldFrame   =frame;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden =YES;
    superView.backgroundColor =[UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    
    [superView addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:self.videoImageUrl placeholderImage:LOADIMAGE(@"tu-icon")];
    
}

-(void)loadBaseUI{
    [superView addSubview:self.playerView];
    [self.playerView addSubview:self.overlayView];
    [self hiddenAllView];
    [self reSetUI];
}

-(void)reSetUI{
    self.overlayView.frame =self.playerView.bounds;
    [self setBigPauseBtn];
    [self setHeaderView];
    [self setFooterView];
}

-(void)setBigPauseBtn{
    CGSize  size ;
    size.width        =60*LSScale;
    size.height       =60*LSScale;
    self.bigPauseButton.frame      =CGRectMake(0, 0, size.width, size.height);
    self.bigPauseButton.center     =self.overlayView.center;
    [self.overlayView addSubview:self.bigPauseButton];
    
}

# pragma mark - headerView
- (void)setHeaderView{
    self.headerView.frame           = CGRectMake(0, 0, self.overlayView.frame.size.width, 38*LSScale);
    [self.overlayView addSubview:self.headerView];
    
    // 返回按钮
    [self setBackButton];
    [self.headerView addSubview:self.backButton];
    
    // 清晰度
    [self setdefinitionBtn];
    [self.headerView addSubview:self.definitionButton];
}

-(void)setdefinitionBtn{
    CGRect frame;
    frame.origin.x    = self.headerView.frame.size.width-5*LSScale-50*LSScale;
    frame.origin.y    = 0;
    frame.size.width  = 50*LSScale;
    frame.size.height = self.headerView.frame.size.height;
    self.definitionButton.frame =frame;
}

- (void)setBackButton{
    CGRect frame;
    frame.origin.x    = 16*LSScale;
    frame.origin.y    = self.headerView.frame.origin.y + 4*LSScale;
    frame.size.width  = self.headerView.frame.size.width -16*2*LSScale-60*LSScale;
    frame.size.height = 30*LSScale;
    self.backButton.frame =frame;
}

-(void)backButtonAction:(UIButton*)btn{
    [self switchScreenAction:self.switchButton];
}

# pragma mark - footerView
- (void)setFooterView
{
    self.footerView.frame = CGRectMake(0, self.overlayView.frame.size.height - 38*LSScale, self.overlayView.frame.size.width, 38*LSScale);
    [self.overlayView addSubview:self.footerView];
    
    // 播放按钮
    [self setplayVideoBtn];
    [self.footerView addSubview:self.playButton];
    // 当前播放时间
    [self setCurrentTimeLabel];
    [self.footerView addSubview:self.currentPlaybackTimeLabel];
    //切换屏幕按钮
    [self setSwitchButton];
    [self.footerView addSubview:self.switchButton];
    // 视频总时间
    [self setTotalTimeLab];
    [self.footerView addSubview:self.totalTimeLabel];
    // 时间滑动条
    [self setDurationSld];
    [self.footerView addSubview:self.durationSlider];
}


-(void)setTotalTimeLab{
    CGRect frame;
    frame.origin.x     = CGRectGetMinX(self.switchButton.frame)-50*LSScale;
    frame.origin.y     = 0;
    frame.size.width   = 50*LSScale;
    frame.size.height  = self.footerView.frame.size.height;
    self.totalTimeLabel.frame=frame;
}

-(void)setDurationSld{
    CGRect frame;
    frame.origin.x     = CGRectGetMaxX(self.currentPlaybackTimeLabel.frame) ;
    frame.origin.y     = 0;
    frame.size.width   = CGRectGetMinX(self.totalTimeLabel.frame) - CGRectGetMaxX(self.currentPlaybackTimeLabel.frame);
    frame.size.height  = self.footerView.frame.size.height;
    self.durationSlider.frame =frame;
}

-(void)setplayVideoBtn{
    CGRect frame;
    frame.origin.x     = 10*LSScale;
    frame.origin.y     = 0;
    frame.size.width   = 38*LSScale;
    frame.size.height  = self.footerView.frame.size.height;
    self.playButton.frame=frame;
}

-(void)setCurrentTimeLabel{
    CGRect frame;
    frame.origin.x     = CGRectGetMaxX(self.playButton.frame);
    frame.origin.y     = 0;
    frame.size.width   = 50*LSScale;
    frame.size.height  = self.footerView.frame.size.height;
    self.currentPlaybackTimeLabel.frame=frame;
}

-(void)playVideoButton:(UIButton *)btn{
    _playButton.selected =!_playButton.selected;
    if (_playButton.selected) {
        [_playButton setImage:[UIImage imageNamed:@"player-pausebutton"] forState:UIControlStateNormal];
        [self playVideo];
    }else{
        [_playButton setImage:[UIImage imageNamed:@"player-playbutton"] forState:UIControlStateNormal];
        [self pauseVideo];
    }
}

# pragma - mark - 屏幕翻转
-(void)setSwitchButton{
    CGRect frame;
    frame.origin.x     = self.footerView.frame.size.width - 50*LSScale;
    frame.origin.y     = 0;
    frame.size.width   = 40*LSScale;
    frame.size.height  = 40*LSScale;
    self.switchButton.frame=frame;
}

-(void)switchScreenAction:(UIButton *)button{
    self.switchButton.selected = !self.switchButton.selected;
    if (self.switchButton.selected == YES) {
        [self fullScreenFrameChanges];
        self.isFullscreen = YES;
    }
    else{
        [self smallScreenFrameChanges];
        self.isFullscreen = NO;
    }
    [self reSetUI];
    [self showAllView];
}

-(void)smallScreenFrameChanges{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.backButton.hidden     =YES;
    [UIView animateWithDuration:0.3f animations:^{
        superView.transform    = CGAffineTransformIdentity;
        superView.frame        =_oldFrame;
        self.playerView.frame =superView.bounds;
    } completion:^(BOOL finished) {
    }];
}

-(void)fullScreenFrameChanges{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.backButton.hidden    =NO;
    [UIView animateWithDuration:0.3f animations:^{
        superView.transform   = CGAffineTransformMakeRotation(M_PI/2);
        superView.frame       = LSMainScreen;
        self.playerView.frame = superView.bounds;
    } completion:^(BOOL finished) {
    }];
}

//播放
-(void)playVideo{
    if (!self.playerView.playing) {
        [self.playerView play];
    }
    self.bigPauseButton.hidden =YES;
}
//暂停
-(void)pauseVideo{
    if (self.playerView.playing) {
        [self.playerView pause];
    }
    self.bigPauseButton.hidden =NO;
}

//显示所有控件
-(void)showAllView{
    if (!self.isFullscreen) {
        self.headerView.hidden     =YES;
    }else{
        self.headerView.hidden     =NO;
    }
    self.footerView.hidden     =NO;
    if (self.playerView.playing) {
        self.bigPauseButton.hidden =YES;
    }else{
        self.bigPauseButton.hidden =NO;
    }
}
//隐藏所有控件
-(void)hiddenAllView{
    self.headerView.hidden     =YES;
    self.footerView.hidden     =YES;
    self.bigPauseButton.hidden =YES;
}

# pragma mark - timer
- (void)addTimer{
    self.hiddenDelaySeconds =5;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

- (void)removeTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer =nil;
    }
}

- (void)timerHandler{
    //当前播放
    float proSec = CMTimeGetSeconds([self.playerView.player currentTime]);
    self.currentPlaybackTimeLabel.text =[DWTools formatSecondsToString:proSec];
    
    //总时长
    float durSec =CMTimeGetSeconds(self.playerView.player.currentItem.duration);
    self.totalTimeLabel.text =[DWTools formatSecondsToString:durSec];
    
    //进度条
    self.durationSlider.value =(float) proSec / durSec;
    
    if (self.hiddenDelaySeconds > 0) {
        if (self.hiddenDelaySeconds == 1) {
            self.didHiddenAll =YES;
            [self hiddenAllView];
        }
        self.hiddenDelaySeconds--;
    }
}

# pragma - mark - 加载视频 method
-(void)getPlayUrl{
//    self.playerView.videoId =@"2DBC15008476D84C9C33DC5901307461";
    self.playerView.videoId =self.videoId;
    [self.playerView startRequestPlayInfo];
    [self.hud show:YES];
    WS(weakSelf)
    self.playerView.getPlayUrlsBlock = ^(NSDictionary *playUrls) {
//        weakSelf.hud.hidden =YES;
        NSNumber *status = [playUrls objectForKey:@"status"];
        if (status == nil || [status integerValue] != 0) {
            [LsMethod alertMessage:@"视频正在审核中,请稍后再试" WithTime:1.5];
            return ;
        }
        
        [weakSelf loadBaseUI];
        [weakSelf addTimer];
        weakSelf.model        =[LsVideoModel yy_modelWithDictionary:playUrls];
        LsVideoModel *modelll =weakSelf.model.videoModelArray[weakSelf.qualityIndex];
        [weakSelf.playerView setURL:modelll.playurl withCustomId:CHANNEL];
        [weakSelf.playerView play];
        
    };
}

// 可播放／播放中
- (void)videoPlayerIsReadyToPlayVideo:(DWPlayerView *)playerView{

    [self showAllView];
    self.imageView.hidden=YES;
    self.hud.hidden =YES;
    //读取原先的播放时间 用oldTimeScrub方法 stopScrubbing:停止滑动并播放
    if (self.switchTime) {
        [self.playerView oldTimeScrub:self.switchTime];
        [self.playerView stopScrubbing];
    }else{
        [self pauseVideo];
    }
}

//播放完毕
- (void)videoPlayerDidReachEnd:(DWPlayerView *)playerView{
    [self playVideoButton:self.playButton];
    [self showAllView];
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
//    [self.playerView setURL:[NSURL URLWithString:[self.currentPlayUrl objectForKey:@"spareurl"]] withCustomId:nil];
//    [self.playerView play];
//
//    self.isPlayable =NO;
    self.hud.hidden =YES;
    NSLog(@"错误原因%@",[error localizedDescription]);
}

#pragma mark---观察者方法 player的播放 暂停属性
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//
//    if (object == self.playerView) {
//        if ([keyPath isEqualToString:@"playing"]) {
//            BOOL isPlaying =[[change objectForKey:@"new"] boolValue];
//            if (isPlaying) {
//                self.isPlayable = YES;
//                [self.playButton setImage:[UIImage imageNamed:@"player-pausebutton"] forState:UIControlStateNormal];
//                LsLog(@"movie playing");
//            }else{
//                //暂停
//                [self.playButton setImage:[UIImage imageNamed:@"player-playbutton"] forState:UIControlStateNormal];
////                self.videoStatusLabel.hidden = NO;
//                LsLog(@"movie paused");
//            }
//        }
//    }
//}

# pragma mark 播放状态提示
- (void)loadVideoStatusLabel
{
//    CGRect frame = CGRectZero;
//    frame.size.height = 40;
//    frame.size.width = 100;
//    frame.origin.x = self.overlayView.frame.size.width/2 - frame.size.width/2;
//    frame.origin.y = self.overlayView.frame.size.height/2 - frame.size.height/2;
//
//    self.videoStatusLabel.frame = frame;
//    if (self.pausebuttonClick) {
//        self.videoStatusLabel.text = @"暂停";
//    }else{
//        self.videoStatusLabel.text = @"正在加载";
//    }
//    self.videoStatusLabel.textAlignment = NSTextAlignmentCenter;
//    self.videoStatusLabel.textColor = [UIColor whiteColor];
//    self.videoStatusLabel.backgroundColor = [UIColor clearColor];
//    self.videoStatusLabel.font = [UIFont systemFontOfSize:16];
//    [self.overlayView addSubview:self.videoStatusLabel];
}


# pragma mark - 手势识别 UIGestureRecognizerDelegate
-(void)handleSignelTap:(UIGestureRecognizer*)gestureRecognizer{
    if (self.didHiddenAll) {
        self.didHiddenAll =NO;
        [self showAllView];
        self.hiddenDelaySeconds = 6;
        if (self.playerView.playing) {
            self.bigPauseButton.hidden=YES;
        }
    }else{
        self.didHiddenAll =YES;
        [self hiddenAllView];
        self.hiddenDelaySeconds = 0;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer == self.signelTap) {
        if ([touch.view isKindOfClass:[UISlider class]]) {
            return NO;
        }
    }
    return YES;
}

#pragma - mark - 各种控件
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,LSMainScreenW,LSMainScreenW*LSScaleW_H)];
        _imageView.contentMode =UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor  =[UIColor redColor];
    }
    return _imageView;
}

-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
        _hud.mode = MBProgressHUDModeIndeterminate;
//        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

-(DWPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[DWPlayerView alloc] initWithUserId:CC_USERID key:CC_APIKEY];
        _playerView.frame =CGRectMake(0,0,LSMainScreenW,LSMainScreenW*LSScaleW_H);
        _playerView.videoGravity =AVLayerVideoGravityResizeAspect;
        _playerView.delegate =self;//设置代理
        _playerView.backgroundColor =[UIColor clearColor];
//         [_playerView addObserver:self forKeyPath:@"playing" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _playerView;
}

-(UIView *)overlayView{
    if (!_overlayView) {
        _overlayView  =[[UIView alloc] initWithFrame:CGRectMake(0,0,LSMainScreenW,LSMainScreenW*LSScaleW_H)];
        _overlayView.backgroundColor =[UIColor clearColor];
        self.signelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSignelTap:)];
        self.signelTap.numberOfTapsRequired = 1;
        self.signelTap.delegate = self;
        [self.overlayView addGestureRecognizer:self.signelTap];
    }
    return _overlayView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView =[[UIView alloc]init];
        _headerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return _headerView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]init];
        _footerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return _footerView;
}

-(UIButton *)backButton{
    if (!_backButton) {
        _backButton   =[[UIButton alloc] init];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton setTitle:[NSString stringWithFormat:@"  %@",self.titleStr] forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"player-back-button"] forState:UIControlStateNormal];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_backButton addTarget:self action:@selector(backButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
        _backButton.hidden  =YES;
    }
    return _backButton;
}

-(UIButton *)switchButton{
    if (!_switchButton) {
        _switchButton =[[UIButton alloc] init];
        _switchButton.backgroundColor = [UIColor clearColor];
        _switchButton.showsTouchWhenHighlighted = YES;
        [_switchButton setImage:[UIImage imageNamed:@"fullscreen.png"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"nonfullscreen.png"] forState:UIControlStateSelected];
        [_switchButton addTarget:self action:@selector(switchScreenAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}

-(UIButton *)bigPauseButton{
    if (!_bigPauseButton) {
        _bigPauseButton = [[UIButton alloc]init];
        [_bigPauseButton setImage:[UIImage imageNamed:@"big_stop_ic"] forState:UIControlStateNormal];
        [_bigPauseButton addTarget:self action:@selector(playVideoButton:) forControlEvents:UIControlEventTouchUpInside];
        _bigPauseButton.hidden = NO;
    }
    return _bigPauseButton;
}

-(UIButton *)playButton{
    if (!_playButton) {
        _playButton =[[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"player-playbutton"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playVideoButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

-(UIButton *)definitionButton{
    if (!_definitionButton) {
        _definitionButton =[[UIButton alloc] init];
        [_definitionButton setTitle:@"清晰" forState:UIControlStateNormal];
        [_definitionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _definitionButton.titleLabel.font   =[UIFont systemFontOfSize:13*LSScale];
        [_definitionButton addTarget:self action:@selector(switchDefinition) forControlEvents:UIControlEventTouchUpInside];
    }
    return _definitionButton;
}

-(void)switchDefinition{
    if (self.model.videoModelArray.count>1) {
        self.definitionButton.selected =!self.definitionButton.selected;
        if (self.definitionButton.selected) {
            [_definitionButton setTitle:@"高清" forState:UIControlStateNormal];
            [_definitionButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            self.qualityIndex =1;
        }else{
            [_definitionButton setTitle:@"清晰" forState:UIControlStateNormal];
            [_definitionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.qualityIndex =0;
        }
        [self switchQuality:self.qualityIndex];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText =@"没有更高的清晰度";
        hud.margin = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        hud.transform=CGAffineTransformMakeRotation(M_PI/2);
        [hud hide:YES afterDelay:1.5];
    }
}

//切换清晰度
- (void)switchQuality:(NSInteger)index{
    self.hud.hidden =NO;
    self.switchTime = CMTimeGetSeconds([self.playerView.player currentTime]);
    LsVideoModel *modelll =self.model.videoModelArray[self.qualityIndex];
    [self.playerView switchQuality:modelll.playurl];
}


-(UILabel *)currentPlaybackTimeLabel{
    if (!_currentPlaybackTimeLabel) {
        _currentPlaybackTimeLabel               =[[UILabel alloc] init];
        _currentPlaybackTimeLabel.text          = @"00:00:00";
        _currentPlaybackTimeLabel.textAlignment =NSTextAlignmentCenter;
        _currentPlaybackTimeLabel.textColor     = [UIColor whiteColor];
        _currentPlaybackTimeLabel.font          = [UIFont systemFontOfSize:10];
        _currentPlaybackTimeLabel.backgroundColor = [UIColor clearColor];
    }
    return _currentPlaybackTimeLabel;
}

-(UISlider *)durationSlider{
    if (!_durationSlider) {
        _durationSlider =[[UISlider alloc] init];
        _durationSlider.minimumValue = 0.0f;
        _durationSlider.maximumValue = 1.0f;
        _durationSlider.value = 0.0f;
        _durationSlider.continuous = NO;
        [_durationSlider setMaximumTrackImage:[UIImage imageNamed:@"player-slider-inactive"]
                                         forState:UIControlStateNormal];
        [_durationSlider setMinimumTrackImage:[UIImage imageNamed:@"slider"]
                                         forState:UIControlStateNormal];
        [_durationSlider setThumbImage:[UIImage imageNamed:@"player-slider-handle"]
                                  forState:UIControlStateNormal];
        [_durationSlider addTarget:self action:@selector(durationSliderMoving:) forControlEvents:UIControlEventEditingDidBegin];
        [_durationSlider addTarget:self action:@selector(durationSliderDone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _durationSlider;
}

- (void)durationSliderMoving:(UISlider *)slider{
    LsLog(@"开始拖动------------");
}

- (void)durationSliderDone:(UISlider *)slider{
    float seconds =slider.value;
    CGFloat durationInSeconds = CMTimeGetSeconds(self.playerView.player.currentItem.duration);
    
    CGFloat time = durationInSeconds * seconds;
    self.currentPlaybackTimeLabel.text =[DWTools formatSecondsToString:time];
    //让视频从指定的CMTime对象处播放。滑动用scrub方法
    [self.playerView scrub:time];
    //   [self.playerView play];
    [self.playerView stopScrubbing];
}

-(UILabel *)totalTimeLabel{
    
    if (!_totalTimeLabel) {
        _totalTimeLabel                         =[[UILabel alloc] init];
        _totalTimeLabel.text                    = @"00:00:00";
        _totalTimeLabel.textAlignment           =NSTextAlignmentCenter;
        _totalTimeLabel.textColor               = [UIColor whiteColor];
        _totalTimeLabel.font                    = [UIFont systemFontOfSize:10];
        _totalTimeLabel.backgroundColor         = [UIColor clearColor];
    }
    return _totalTimeLabel;
    
}

#pragma - mark - 前后台操作
- (void)appDidEnterBackground{
    LsLog(@"----------进入后台------------");
    if (self.playerView.playing) {
        [self playVideoButton:self.playButton];
    }
}

- (void)appWillEnterForegroundNotification{
    LsLog(@"----------进入前台------------");
    [self showAllView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    LsLog(@"----------------stop movie-----------------");
    if (self.playerView.playing) {
        [self playVideoButton:self.playButton];
    }
    
}

- (void)removeAllObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.playerView removeObserver:self forKeyPath:@"playing"];
}

-(void)setVideoId:(NSString *)videoId{
    _videoId =videoId;
    [self getPlayUrl];
}

-(void)dealloc{
    LsLog(@"-------------------HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH------------------");
    
    [self.playerView cancelRequestPlayInfo];
    //    [self saveNsUserDefaults];
    //关闭player
    self.playerView.delegate =nil;
    [self.playerView resetPlayer];
    self.playerView =nil;
    
    //    self.secondsCountDown = -1;
    [self removeAllObserver];
    //    [self removeTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
