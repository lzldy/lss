//
//  LsLiveDetailTableViewCell.h
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsLiveDetailModel.h"

@protocol liveDetailTableViewCellDelegate <NSObject>

- (void)didClickPlayBtnWithID:(NSString*)videoid;

@end

@interface LsLiveDetailTableViewCell : UITableViewCell

@property (nonatomic,  weak)  id<liveDetailTableViewCellDelegate> delegate;

-(void)reloadCell:(LsCourseArrangementModel*)model;

@end
