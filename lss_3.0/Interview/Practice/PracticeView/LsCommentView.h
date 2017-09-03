//
//  LsCommentView.h
//  lss
//
//  Created by apple on 2017/9/3.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol commentViewDelegate <NSObject>

- (void)didClickCommitButton:(NSString*)text;

@end


@interface LsCommentView : UIView

@property (nonatomic,strong)  NSString   *textPlaceholder;
@property (nonatomic,strong)  NSString   *commitBtnText;

@property (nonatomic, weak) id<commentViewDelegate> delegate;

@end
