//
//  LsBaseCollectionViewCell.h
//  lss
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LsBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)  UILabel   *label;
@property (nonatomic,assign)  NSInteger section;
@property (nonatomic,assign)  NSInteger row;
@property (nonatomic,assign)  BOOL      didClick;

-(void)reloadDataWith:(id)data;

@end
