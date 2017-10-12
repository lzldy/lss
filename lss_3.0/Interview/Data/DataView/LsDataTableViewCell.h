//
//  LsDataTableViewCell.h
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsDataModel.h"

@interface LsDataTableViewCell : UITableViewCell

-(void)reloadCell:(LsDataModel*)model Image:(BOOL)haveImage;

@end
