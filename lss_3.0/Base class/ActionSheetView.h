//
//  ActionSheetView.h
//  Policy
//
//  Created by 李子龙 on 16/10/12.
//  Copyright © 2016年 lzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionSheetViewDelegate <NSObject>

-(void)chooseBtn:(NSString *)type;

@end

@interface ActionSheetView : UIView

@property (nonatomic,weak) id <ActionSheetViewDelegate> delegate;

@end
