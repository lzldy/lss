//
//  LsMyLiveListTableViewCell.h
//  lss
//
//  Created by apple on 2017/11/29.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsMyLiveModel.h"

@protocol myLiveListTableViewCellDelegate <NSObject>

@optional

- (void)didClickEvaluateBtnIndex:(LsButton*)btn;

@end

@interface LsMyLiveListTableViewCell : UITableViewCell

@property (nonatomic,weak) id<myLiveListTableViewCellDelegate> delegate;

-(void)reloadCell:(LsMyLiveModel*)model Type:(NSString*)type;

@end
