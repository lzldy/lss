//
//  LsMyVideoModel.h
//  lss
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsMyVideoModel : NSObject

@property (nonatomic,strong)  NSURL         *videoHeadUrl2;
@property (nonatomic,strong)  NSURL         *videoHeadUrl;
@property (nonatomic,strong)  NSString      *title;
@property (nonatomic,strong)  NSString      *startTime;
@property (nonatomic,strong)  NSString      *code;

@property (nonatomic,strong)  UIImage       *image;


@property (nonatomic,strong)  NSArray       *list;
@end
