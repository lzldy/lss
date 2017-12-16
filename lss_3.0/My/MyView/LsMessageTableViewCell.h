//
//  LsMessageTableViewCell.h
//  lss
//
//  Created by apple on 2017/12/16.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsMessageModel.h"

@interface LsMessageTableViewCell : UITableViewCell

-(void)reloadCellWithData:(LsMessageModel*)data;

@end
