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

@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,assign) CGRect       oldFrame;
@property (nonatomic,strong) DWPlayerView *playerView;
@property (nonatomic,strong) LsVideoModel *model;
@property (nonatomic,assign) NSInteger    qualityIndex;
@property (nonatomic,assign) BOOL         isPlayable;
@property (nonatomic,assign) BOOL         isFullscreen;
@property (strong, nonatomic)UIView       *headerView;
@property (strong, nonatomic)UIView       *footerView;
@property (strong, nonatomic)UIView       *overlayView;

@property (strong, nonatomic)UIButton     *backButton;


@property (strong, nonatomic)UIButton     *playButton;
@property (strong, nonatomic)UIButton     *switchButton;

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
    superView.backgroundColor =LSNavColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
}

-(void)loadBaseUI{
    [superView addSubview:self.playerView];
    [self.playerView addSubview:self.overlayView];
    [self reSetUI];
}

-(void)reSetUI{
    self.overlayView.frame =self.playerView.bounds;
    [self setHeaderView];
    [self setFooterView];
}

# pragma mark - headerView
- (void)setHeaderView
{
    self.headerView.frame           = CGRectMake(0, 0, self.overlayView.frame.size.width, 38*LSScale);
    [self.overlayView addSubview:self.headerView];
    
    // 返回按钮
    [self.headerView addSubview:self.backButton];
    [self setBackButton];
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
//    self.playbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 当前播放时间
//    self.currentPlaybackTimeLabel = [[UILabel alloc] init];
    
    // 画面尺寸
//    self.screenSizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    // 视频总时间
//    self.durationLabel = [[UILabel alloc] init];
    
    // 时间滑动条
//    self.durationSlider = [[UISlider alloc] init];
//    [self durationSlidersetting];
    
    //切换屏幕按钮
    [self.footerView addSubview:self.switchButton];
    [self setSwitchButton];
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

# pragma - mark - 加载视频 method
-(void)getPlayUrl{
//    self.playerView.videoId =@"2DBC15008476D84C9C33DC5901307461";
    self.playerView.videoId =self.videoId;
    [self.playerView startRequestPlayInfo];
    [self.hud show:YES];
    WS(weakSelf)
    self.playerView.getPlayUrlsBlock = ^(NSDictionary *playUrls) {
        [weakSelf.hud hide:YES];
        NSNumber *status = [playUrls objectForKey:@"status"];
        if (status == nil || [status integerValue] != 0) {
            [LsMethod alertMessage:@"视频正在审核中,请稍后再试" WithTime:1.5];
            return ;
        }
        
        [weakSelf loadBaseUI];
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
//    [self.playerView setURL:[NSURL URLWithString:[self.currentPlayUrl objectForKey:@"spareurl"]] withCustomId:nil];
//    [self.playerView play];
//
//    self.isPlayable =NO;
    
    NSLog(@"错误原因%@",[error localizedDescription]);
}

#pragma mark---观察者方法 player的播放 暂停属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self.playerView) {
        if ([keyPath isEqualToString:@"playing"]) {
            BOOL isPlaying =[[change objectForKey:@"new"] boolValue];
            if (isPlaying) {
                self.isPlayable = YES;
                [self.playButton setImage:[UIImage imageNamed:@"player-pausebutton"] forState:UIControlStateNormal];
                LsLog(@"movie playing");
            }else{
                //暂停
                [self.playButton setImage:[UIImage imageNamed:@"player-playbutton"] forState:UIControlStateNormal];
//                self.videoStatusLabel.hidden = NO;
                LsLog(@"movie paused");
            }
        }
    }
}

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

-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

-(DWPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[DWPlayerView alloc] initWithUserId:CC_USERID key:CC_APIKEY];
        _playerView.frame =CGRectMake(0,0,LSMainScreenW,LSMainScreenW*LSScaleW_H);
        _playerView.videoGravity =AVLayerVideoGravityResizeAspect;
        _playerView.delegate =self;//设置代理
        _playerView.backgroundColor =LSLineColor;
         [_playerView addObserver:self forKeyPath:@"playing" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _playerView;
}

-(UIView *)overlayView{
    if (!_overlayView) {
        _overlayView  =[[UIView alloc] initWithFrame:CGRectMake(0,0,LSMainScreenW,LSMainScreenW*LSScaleW_H)];
        _overlayView.backgroundColor =[UIColor clearColor];
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
        [_backButton setTitle:@"  视频标题" forState:UIControlStateNormal];
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

- (void)appDidEnterBackground{
    LsLog(@"----------进入后台------------");
    if (self.playerView.playing) {
        [self.playerView pause];
    }
}

- (void)appWillEnterForegroundNotification{
    LsLog(@"----------进入前台------------");
    if (!self.playerView.playing) {
        [self.playerView play];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    LsLog(@"----------------stop movie-----------------");
    [self.playerView cancelRequestPlayInfo];
//    [self saveNsUserDefaults];
    //关闭player
    [self.playerView resetPlayer];
    self.playerView =nil;
    
//    self.secondsCountDown = -1;
    [self removeAllObserver];
//    [self removeTimer];
    
}

- (void)removeAllObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerView removeObserver:self forKeyPath:@"playing"];
}

-(void)setVideoId:(NSString *)videoId{
    _videoId =videoId;
    [self getPlayUrl];
}

-(void)dealloc{
    LsLog(@"-------------------HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH------------------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
