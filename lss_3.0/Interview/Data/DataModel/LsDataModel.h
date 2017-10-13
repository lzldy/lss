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
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *headImgUrl;
@property (nonatomic,strong) NSString *imgUrl;

@end

@interface LsDataModel : NSObject

@property (strong,nonatomic) NSArray *dataArray;

@end
