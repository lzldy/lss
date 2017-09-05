//
//  AppDelegate.h
//  lss_3.0
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/***  是否允许横屏的标记 */
@property (nonatomic,assign)  BOOL allowRotation;

-(void)loadMianTab;

@end

