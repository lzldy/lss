//
//  LsDataModel.h
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsDataDetailModel : NSObject

@property (nonatomic,strong) NSString *id_;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSDate   *createTime;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSURL    *headImgUrl;
//@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *viewTime;


@property (nonatomic,strong) NSURL       *url;
@property (nonatomic,strong) NSString    *content;
@property (nonatomic,strong) NSArray     *imglist;


@end

@interface LsDataModel : NSObject

@property (strong,nonatomic) NSArray *dataArray;

@end
