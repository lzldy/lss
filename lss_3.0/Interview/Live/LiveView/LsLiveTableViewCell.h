//
//  LsLiveTableViewCell.h
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveModel.h"
#import "LsButton.h"


@interface LsLiveTableViewCell : UITableViewCell

-(void)reloadCell:(LsLiveModel*)model Type:(NSString*)type;

@end
