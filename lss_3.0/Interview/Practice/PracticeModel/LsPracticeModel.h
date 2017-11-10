//
//  LsPracticeModel.h
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsPracticeListModel : NSObject

@property (nonatomic,strong) NSURL      *  coverImage;
@property (nonatomic,strong) NSString   *  author;
@property (nonatomic,strong) NSString   *  authorType;
@property (nonatomic,strong) NSString   *  title;
@property (nonatomic,assign) NSInteger     commnetNum;
@property (nonatomic,strong) NSString   *  classType;
@property (nonatomic,strong) NSString   *  uploadDate;
@property (nonatomic,assign) BOOL          isRecommend;

@property (nonatomic,strong) NSURL      *  videoHeadUrl;
@property (nonatomic,strong) NSString   *  teacher;
@property (nonatomic,assign) BOOL          isRefered;
@property (nonatomic,strong) NSString   *  ctag1;
@property (nonatomic,strong) NSString   *  ctag2;
@property (nonatomic,strong) NSString   *  viewtime;
@property (nonatomic,strong) NSString   *  endDate;
@property (nonatomic,strong) NSString   *  startDate;

@property (nonatomic,strong) NSString   *  code;
@property (nonatomic,strong) NSString   *  videoId;

@end

@interface LsPracticeModel : NSObject

@property (nonatomic,assign) NSInteger personNum;
@property (nonatomic,strong) NSArray<LsPracticeListModel*>   *practiceLists;

@property (nonatomic,strong) NSArray   *practiceDataArray;

@end
