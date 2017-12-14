//
//  LsPracticeDetailModel.h
//  lss
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsPracticeCommentModel : NSObject

@property (strong,nonatomic)  NSString *ID;
@property (strong,nonatomic)  NSString *fromUser;
@property (strong,nonatomic)  NSString *fromUserId;
@property (strong,nonatomic)  NSString *fromUserName;
@property (strong,nonatomic)  NSString *fromUserType;
@property (strong,nonatomic)  NSURL    *fromUserHeadUrl;
@property (strong,nonatomic)  NSString *content;
@property (strong,nonatomic)  NSString *createTimeInSec;

@property (strong,nonatomic)  NSString *toUserName;

@property (strong,nonatomic)  NSArray  *replys;
@property (strong,nonatomic)  NSArray  *dataList;

@end

@interface LsPracticeDetailModel : NSObject

@property (nonatomic,strong)    NSURL     * videoHeadUrl;
@property (nonatomic,strong)    NSString  * title;
@property (nonatomic,strong)    NSString  * startDate;
@property (nonatomic,strong)    NSString  * endDate;
@property (nonatomic,assign)    int         zannum;//点赞次数
@property (nonatomic,strong)    NSString  * commentNum;//评论次数
@property (nonatomic,strong)    NSString  * viewtime;//观看次数
@property (nonatomic,strong)    NSString  * commentNum2;
@property (nonatomic,strong)    NSString  * videoId;

@property (nonatomic,assign)    BOOL  myzan;//本人是否点赞

@end
