//
//  LsButton.h
//  lss
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LsButton : UIButton

@property (nonatomic,strong) NSString *videoID;
@property (nonatomic,strong) NSURL    *url;
@property (nonatomic,assign) BOOL     isPackage;
@property (nonatomic,strong) NSString *title;

@end
