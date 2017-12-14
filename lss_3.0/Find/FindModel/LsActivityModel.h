//
//  LsActivityModel.h
//  lss
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsActivityModel : NSObject

@property (nonatomic,strong)  NSString *ID;
@property (nonatomic,strong)  NSString *title;

@property (nonatomic,strong)  NSURL    *headUrl;
@property (nonatomic,strong)  NSURL    *iconUrl;

@property (nonatomic,strong)  NSArray  *dataArray;
@end
