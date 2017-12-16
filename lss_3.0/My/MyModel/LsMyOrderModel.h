//
//  LsMyOrderModel.h
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsMyOrderModel : NSObject

@property (nonatomic,strong)  NSString *ID;
@property (nonatomic,strong)  NSString *title;
@property (nonatomic,strong)  NSString *createTime;
@property (nonatomic,strong)  NSString *frmUserName;

@property (nonatomic,strong)  NSArray  *dataArray;

@end
