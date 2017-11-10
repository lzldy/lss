//
//  LsPracticeDetailModel.h
//  lss
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LsPracticeDetailModel : NSObject

@property (nonatomic,strong)    NSURL     * videoHeadUrl;
@property (nonatomic,strong)    NSString  * title;
@property (nonatomic,strong)    NSString  * startDate;
@property (nonatomic,strong)    NSString  * endDate;
@property (nonatomic,assign)    NSInteger   zannum;
@property (nonatomic,strong)    NSString  * commentNum;
@property (nonatomic,strong)    NSString  * viewtime;

@property (nonatomic,assign)    BOOL  myzan;

@end
