//

//


@import Foundation;
@import AVFoundation;

#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@class DWPlayerView;

@protocol DWVideoPlayerDelegate <NSObject>

@optional

/*
 *
 *AVPlayerItem的三种状态
 *AVPlayerItemStatusUnknown,
 *AVPlayerItemStatusReadyToPlay,
 *AVPlayerItemStatusFailed
 */

//所有的代理方法均已回到主线程 可直接刷新UI
// 可播放／播放中
- (void)videoPlayerIsReadyToPlayVideo:(DWPlayerView *)playerView;

//播放完毕
- (void)videoPlayerDidReachEnd:(DWPlayerView *)playerView;
//当前播放时间 
- (void)videoPlayer:(DWPlayerView *)playerView timeDidChange:(CMTime)cmTime;

//duration 当前缓冲的长度
- (void)videoPlayer:(DWPlayerView *)playerView loadedTimeRangeDidChange:(float)duration;

//进行跳转后没数据 即播放卡顿
- (void)videoPlayerPlaybackBufferEmpty:(DWPlayerView *)playerView;

// 进行跳转后有数据 能够继续播放
- (void)videoPlayerPlaybackLikelyToKeepUp:(DWPlayerView *)playerView;

//加载失败
- (void)videoPlayer:(DWPlayerView *)playerView didFailWithError:(NSError *)error;

@end

typedef void (^DWErrorBlock)(NSError *error);
typedef void(^DWVideoPlayerGetPlayUrlsBlock)(NSDictionary *playUrls);

@interface DWPlayerView : UIView<NSXMLParserDelegate>

@property (nonatomic, weak) id<DWVideoPlayerDelegate> delegate;

/*播放属性*/
@property (nonatomic, strong) AVPlayer      *player;
@property (nonatomic, strong) AVPlayerItem  *item;
@property (nonatomic, strong) AVURLAsset    *urlAsset;
/** playerLayer */
@property (nonatomic, strong) AVPlayerLayer  *playerLayer;

/**
 
 AVPlayerLayer的videoGravity属性设置
 AVLayerVideoGravityResize,       // 非均匀模式。两个维度完全填充至整个视图区域
 AVLayerVideoGravityResizeAspect,  // 等比例填充，直到一个维度到达区域边界
 AVLayerVideoGravityResizeAspectFill, // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
 */
@property (nonatomic, copy) NSString         *videoGravity;

@property (nonatomic, assign) BOOL playing; //播放时为YES 暂停时为NO
@property (nonatomic, assign) BOOL looping;//是否循环播放 默认为NO 在setURL后调用
@property (nonatomic, assign) BOOL muted;//是否静音 默认为NO 在setURL后调用

@property (copy, nonatomic)NSString *userId;
@property (copy, nonatomic)NSString *videoId;
@property (copy, nonatomic)NSString *key;
@property (assign, nonatomic)NSTimeInterval timeoutSeconds;//超时时间

@property (copy, nonatomic)DWVideoPlayerGetPlayUrlsBlock getPlayUrlsBlock;


/**
 *  @brief 获取视频播放信息或播放过程中发生错误或失败时，回调该block。可以在该block内更新UI，如更改视频播放状态。
 */
@property (copy, nonatomic)DWErrorBlock failBlock;


/**
 *  @brief drmServer 绑定的端口。
 *
 *  若你使用了DRM视频加密播放服务，则必须先启动 DWDrmServer，并在调用 prepareToPlay 之前，设置 drmServerPort 设置为 DWDrmServer 绑定的端口。
 */
@property (assign, nonatomic)UInt16 drmServerPort;



/**
 *  @brief 初始化播放对象
 *
 *  @param userId      用户ID，不能为nil
 *  @param videoId     即将播放的视频ID，不能为nill
 *  @param key         用户秘钥，不能为nil
 *
 *  @return 播放对象
 */
- (id)initWithUserId:(NSString *)userId andVideoId:(NSString *)videoId key:(NSString *)key;

/**
 *  @brief 初始化播放对象
 *
 *  @param userId      用户ID，不能为nil
 *  @param key         用户秘钥，不能为nil
 *
 *  @return 播放对象
 */
- (id)initWithUserId:(NSString *)userId key:(NSString *)key;

/**
 *  @brief 开始请求视频播放信息。
 */
- (void)startRequestPlayInfo;

/**
 *  @brief 取消请求视频播放信息
 */
- (void)cancelRequestPlayInfo;

/*setURL方法 添加播放资源   如果有正在播放的资源，会释放掉当前播放的资源
 *customId 用户自定义参数  有自定义统计参数需求／流量统计的客户必须传值
 *                      没有此需求的客户请传nil/@""
 *在不需要统计的地方均传nil/@"" 譬如广告视频／本地播放
 */
- (void)setURL:(NSURL *)URL withCustomId:(NSString *)customId;


//切换清晰度方法
- (void)switchQuality:(NSURL *)URL;

//切换倍速的方法
- (void)setPlayerRate:(float)rate;


//播放
- (void)play;

//暂停
- (void)pause;

//拖动到指定时间
- (void)seekToTime:(float)time;

// 关闭|重置
- (void)resetPlayer;

// AirPlay技术 外部播放设置
//支持AirPlay外部播放
- (void)enableAirplay;
//不支持AirPlay外部播放
- (void)disableAirplay;

//检测是否支持支持AirPlay外部播放
- (BOOL)isAirplayEnabled;

// Time Updates
//添加当前播放时间观察
- (void)enableTimeUpdates; // TODO: need these? no
//移除时间观察
- (void)disableTimeUpdates;

// Scrubbing
/*
 *开始滑动
 */
- (void)startScrubbing;

/*
 * 拖拽方法
 */
- (void)scrub:(float)time;

//滑到原先播放位置的方法
- (void)oldTimeScrub:(float)time;


/*
 *停止滑动 并开始播放
 *调用stopScrubbing方法的前提是先调用 scrub／oldTimeScrub方法
 */
- (void)stopScrubbing;

// Volume

//设置音量
- (void)setVolume:(float)volume;
//加大音量
- (void)fadeInVolume;
//减小音量
- (void)fadeOutVolume;

//获取可播放的持续时间
- (NSTimeInterval )playableDuration;

//获取当前player播放的URL
-(NSURL *)urlOfCurrentlyPlayingInPlayer;

@end
