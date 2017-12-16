//
//  LsMyOrderTableViewCell.h
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsMyOrderModel.h"

@interface LsMyOrderTableViewCell : UITableViewCell

-(void)reloadCellWithData:(LsMyOrderModel*)data;

@end
