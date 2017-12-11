//
//  LsPracticeTableViewCell.h
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsPracticeModel.h"

@interface LsPracticeTableViewCell : UITableViewCell

-(void)reloadCell:(id)model Type:(NSString*)type;

@end
