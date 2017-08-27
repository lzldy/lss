#import <Foundation/Foundation.h>


typedef void (^DWErrorBlock)(NSError *error);
typedef void (^DWPlayInfoFinishBlock)(NSDictionary *response);

@interface DWPlayInfo : NSObject

@property (assign, nonatomic)NSTimeInterval timeoutSeconds;
@property(nonatomic, strong)NSDate *responseTime;

@property (assign, nonatomic)int reason;
@property (strong, nonatomic)NSString *upid;
@property (nonatomic) BOOL isRealTime;
@property (copy, nonatomic)DWErrorBlock errorBlock;
@property (copy, nonatomic)DWPlayInfoFinishBlock finishBlock;

- (id)initWithUserId:(NSString *)userId andVideoId:(NSString *)videoId key:(NSString *)key;
- (id)initWithUserId:(NSString *)userId andVideoId:(NSString *)videoId key:(NSString *)key hlsSupport:(NSString *)hlsSupport;

- (void)start;  

/**
 
 *下面两个方法已被废弃 
 *  @brief 从playinfo接口中取得一个可用的url信息
 *
 *  @return 成功返回url信息，失败返回nil（调用时必须判断其返回值）。
 *  NSDictionary: {"UPID":NSString, "quality":NSNumber, "desp":NSString, "priority":NSNumber, "playurl":NSString}
 
 
 */
- (NSDictionary *)getValidPlayUrlInfo;
- (NSDictionary *)getValidPlayUrlInfoForDownload;

@end
