//
//  LsPlayBackTableViewCell.h
//  lss
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveModel.h" 

@interface LsPlayBackTableViewCell : UITableViewCell

-(void)reloadCellWithData:(LsLiveModel*)model;

@end
