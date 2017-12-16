//
//  LsWrittenTableViewCell.h
//  lss
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsQuestionsModel.h"

@interface LsWrittenTableViewCell : UITableViewCell

-(void)reloadCellWithData:(LsQuestionsDetailModel*)data;

@end
