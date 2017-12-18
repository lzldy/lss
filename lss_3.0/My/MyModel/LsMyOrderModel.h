//
//  LsMyOrderModel.h
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsMyOrderModel : NSObject

@property (nonatomic,strong)  NSString *prodname;//产品名称
@property (nonatomic,strong)  NSString *ordersn;//订单号
@property (nonatomic,strong)  NSString *nickname;//订购人
@property (nonatomic,strong)  NSString *paytime;//支付时间
@property (nonatomic,strong)  NSString *mobile;//支付时间
@property (nonatomic,strong)  NSString *payflag;//支付状态
@property (nonatomic,strong)  NSString *orderamount;//订单金额
@property (nonatomic,strong)  NSString *paymoney;//支付金额
@property (nonatomic,strong)  NSString *createtime;

@property (nonatomic,strong)  NSArray  *list;

@end
