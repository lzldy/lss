//
//  LsActivityTableViewCell.h
//  lss
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsActivityModel.h"

@interface LsActivityTableViewCell : UITableViewCell


-(void)reloadCell:(LsActivityModel*)model;

@end
