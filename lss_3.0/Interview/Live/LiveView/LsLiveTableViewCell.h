//
//  LsLiveTableViewCell.h
//  lss
//
//  Created by apple on 2017/8/11.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveModel.h"

@protocol liveTableViewCellDelegate <NSObject>

@optional
- (void)didClickIntoBtnIndex:(NSInteger)index;
- (void)didClickEvaluateBtnIndex:(NSInteger)index;

@end

@interface LsLiveTableViewCell : UITableViewCell

@property (nonatomic,weak) id<liveTableViewCellDelegate> delegate;

-(void)reloadCell:(LsLiveModel*)model Type:(NSString*)type;

@end
