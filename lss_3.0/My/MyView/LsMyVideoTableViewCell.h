//
//  LsMyVideoTableViewCell.h
//  lss
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LsMyVideoModel.h"

@protocol MyVideoTableViewCellDelegate <NSObject>

- (void)didClickBtnIndex:(LsButton*)btn;

@end

@interface LsMyVideoTableViewCell : UITableViewCell

@property (nonatomic, weak)  id<MyVideoTableViewCellDelegate> delegate;

-(void)reloadCell:(LsMyVideoModel *)model  type:(NSString*)type;

@end
