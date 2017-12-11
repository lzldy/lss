//
//  LsCommentTableViewCell.h
//  lss
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsPracticeDetailModel.h"
@protocol commentTableViewCellDelegate <NSObject>

- (void)replyComment:(LsButton *)button;

@end

@interface LsCommentTableViewCell : UITableViewCell

@property (nonatomic, weak) id<commentTableViewCellDelegate> delegate;

-(void)reloadCellWithData:(id)data type:(NSString*)type;

@end
