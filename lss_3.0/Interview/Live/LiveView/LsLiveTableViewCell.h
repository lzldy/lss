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

@protocol liveTableViewCellDelegate <NSObject>

@optional

- (void)didClickIntoBtn:(NSString *)ID  isPackage:(BOOL)ispackage;
- (void)didClickEvaluateBtnIndex:(LsButton*)btn;

@end

@interface LsLiveTableViewCell : UITableViewCell

@property (nonatomic,weak) id<liveTableViewCellDelegate> delegate;

-(void)reloadCell:(LsLiveModel*)model Type:(NSString*)type;

@end
